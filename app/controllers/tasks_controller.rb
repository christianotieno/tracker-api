class TasksController < ApplicationController
  before_action :find_schedule
  before_action :find_task, only: %i[show update destroy]

  def index
    render json: @schedule.tasks
  end

  def show
    render json: @task
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task
    else

      render json: { error: 'Unable to create Task' }, status: 400
    end
  end

  def update
    if @task
      @task.update(task_params)
      render json: { message: 'Task succesfully updated' }, status: 200
    else
      render json: { error: 'Unable to update Task' }, status: 400
    end
  end

  def destroy
    if @task
      @task.destroy
      render json: { message: 'Task succesfully deleted' }, status: 200
    else
      render json: { error: 'Unable to delete Task' }, status: 400
    end
  end

  private

  def task_params
    params.require(:task).permit(:id, :date, :done, :name, :schedule_id, :notes)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def find_schedule
    @schedule = Schedule.find(params[:schedule_id])
  end
end
