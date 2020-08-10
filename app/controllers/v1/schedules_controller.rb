module V1
  class SchedulesController < ApplicationController
    before_action :set_schedule, only: %i[show update destroy]

    # GET /schedules
    def index
        # get current user schedules
      @schedules = current_user.schedules.paginate(page: params[:page], per_page: 20)
      json_response(@schedules)
    end

    # POST /schedules
    def create
        # create todos belonging to current user
      @schedule = current_user.schedules.create!(schedule_params)
      json_response(@schedule, :created)
    end

    # GET /schedules/:id
    def show
      json_response(@schedule)
    end

    # PUT /schedules/:id
    def update
      @schedule.update(schedule_params)
      head :no_content
    end

    # DELETE /schedules/:id
    def destroy
      @schedule.destroy
      head :no_content
    end

    private

    def schedule_params
      # whitelist params
      params.permit(:title)
    end

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
  end
end