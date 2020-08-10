module V1
  class TasksController < ApplicationController
    before_action :set_schedule
    before_action :set_schedule_task, only: %i[show update destroy]

    # GET /todos/:schedule_id/tasks
    def index
      json_response(@schedule.tasks)
    end

    # GET /schedules/:schedule_id/tasks/:id
    def show
      json_response(@task)
    end

    # POST /todos/:todo_id/items
    def create
      @schedule.tasks.create!(task_params)
      json_response(@schedule, :created)
    end

    # PUT /schedules/:schedule_id/tasks/:id
    def update
      @task.update(task_params)
      head :no_content
    end

    # DELETE /schedules/:schedule_id/tasks/:id
    def destroy
      @task.destroy
      head :no_content
    end

    private

    def task_params
      params.permit(:name, :done)
    end

    def set_schedule
      @schedule = Schedule.find(params[:schedule_id])
    end

    def set_schedule_task
      @task = @schedule.tasks.find_by!(id: params[:id]) if @schedule
    end
  end
end