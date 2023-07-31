class TasksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_task, only: [:show, :update, :destroy]
    
    #GET /tasks
    def index
      pages = 1
      limit = 10
      order = 'id'
      direction = 'asc'
      pages = params[:pages] if params[:pages].present?
      limit = params[:limit] if params[:limit].present?
      order = params[:order] if params[:order].present?
      direction = params[:direction] if params[:direction].present?
      sentence_order = order + ' ' + direction

      user_tasks = Task.where(user_id: current_user.id).order(sentence_order)
      tasks = user_tasks.page(pages).per(limit)

      render json: {tasks: ActiveModel::Serializer::CollectionSerializer.new(tasks)}
    end

    #GET /tasks/1
    def show
      render json: {task: @task}
    end

    # POST /tasks
    def create
      title = task_params[:title]
      description = task_params[:description]
      user_id = current_user.id

      task = Task.new(title: title, description: description, user_id: user_id)

      if task.save
        render json: {task: task}
      else
        error_message = task.errors.messages[:title][0]
        render json: {error: error_message}
      end
    end

    # PATCH/PUT /tasks/1
    def update
      title = task_params[:title]
      description = task_params[:description]
      
      task = @task.update(title: title, description: description)

      if task
        render json: {task: @task}
      else
        error_message = @task.errors.messages[:title][0]
        render json: {error: error_message}
      end
    end

    # DELETE /tasks/1
    def destroy
      task = @task.delete

      render json: {message: 'Eliminado'}
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      begin
        @task = Task.find(params[:id])
        #@task = Task.find_by(id: params[:id], user_id: current_user.id)
      rescue
        render json: {error: 'La tarea no existe'}
      end
    end
    # Only allow a trusted parameter "white list" through.
    def task_params
      task_params = params.require(:task).permit(:title, :description, :user_id)
    end
end
