class Task < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :project

	# get all statuses, not repeating, alphabetically ordered
	def self.getTasksStatus
		statuses = Task.order(:status).pluck(:status)	
	end
	#get the tasks for all projects having the name beginning with “N” letter
	def self.startWithN
		tasks_names = Task.where( "name LIKE ?", "N%" ).pluck(:name)
	end


	# get the list of tasks with duplicate names. Order alphabetically
	def self.duplicateNames
		tasks_names = ( Task.pluck(:name) & Task.distinct.pluck(:name) ).sort!
	end


	# get the list of tasks having several exact matches of both name and status, from the
	# project ‘Garage’. Order by matches count
	def self.garage
		tasks_dupl = Project.find_by( name: 'Garage' ).tasks & Project.distinct.find_by( name: 'Garage' ).tasks

		result = Hash.new

		( 0 ... tasks_dupl.length).each { |i| result[i] = tasks_dupl[i] }

	end

end
