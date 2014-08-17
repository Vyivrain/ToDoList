class Project < ActiveRecord::Base
	validates :name, presence: true
	has_many :tasks, dependent: :destroy

	#helper
	def self.getProjectTasks

		project_counts = []

		Project.find_each do |project|
			project_counts << project.tasks.count
		end

		project_counts

	end


	#get the count of all tasks in each project, order by tasks count descending
	def self.getTasksOrderDesc

		countTasks = Project.getProjectTasks		

		countTasks.sort! { |x,y| y <=> x }		

	end

	#get the count of all tasks in each project, order by projects names
	def self.getTasksOrderProj

		countTasks = Project.getProjectTasks

		project_names = Project.pluck(:name)

		result = Hash.new

		countTasks.zip(project_names){ |countTask, project|  result[project.name] = countTasks }

		result.keys.sort!

	end

	# get the list of all projects containing the ‘a’ letter in the middle of the name, and show the
	# tasks count near each project. Mention that there can exist projects without tasks and
	# tasks with project_id=NULL
	def self.listProjects

		result = Hash.new

		projects_name = Project.where( "name LIKE ?", "%a%" ).pluck(:name)

		project_names.each do |name|
			result[name] = Project.find_by( name: name ).tasks.count
		end
		
		result	

	end
	
	#get the list of project names having more than 10 tasks in status ‘completed’. Order by
	#project_id
	def self.finishedProj
		projects = Project.all

		result = []

		Project.find_each do |project|

			completed = project.tasks.where( status: "completed" ).count

			result << completed

		end

		result.sort_by{ |e| :id } 

	end

end
