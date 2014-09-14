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
    @task = project.tasks.create( name: params[:task_name], status: params[:status], project_id: @project_name, position: project.tasks.count )

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task was successfully created.' }
        format.js 
      else
        format.html { redirect_to root_path }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to root_path, notice: 'Task was successfully updated.' }
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
      format.html { redirect_to root_path, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  def update_data

      ids = params[:swap].split('&')

      @row1 = Task.find ids.first
      @row2 = Task.find ids.last

      temp = @row1.position
      @row1.update_attributes(position: @row2.position)
      @row2.update_attributes(position: temp)

      respond_to do |format|
        format.js
      end

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
