class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project_name = params[:project_name]
    project = Project.where( name: @project_name ).take!
    @task = project.tasks.create( name: params[:task_name], status: params[:status], project_id: @project_name )

    respond_to do |format|
      if @task.save
        format.html { redirect_to projects_path, notice: 'Task was successfully created.' }
        format.js 
      else
        format.html { redirect_to projects_path }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to projects_path, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_data

    ids = params[:swap].split('&')

    row1 = Task.where( id: ids[0] ).first
    row2 = Task.where( id: ids[1] ).first

    temp_hash1 = { name: row1.name, status: row1.status, project_id: row1.project_id, dead_line: row1.dead_line }
    temp_hash2 = { name: row2.name, status: row2.status, project_id: row2.project_id, dead_line: row2.dead_line }

    @task = row1
    @task.update_attributes( temp_hash2 )

    @task = row2
    @task.update_attributes( temp_hash1 )

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:id, :name, :status, :project_id, :dead_line)
    end
end
