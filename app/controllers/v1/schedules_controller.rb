module V1
  class SchedulesController < ApplicationController
    before_action :find_user
    before_action :find_schedule, only: %i[show update destroy]

  def index
    render json: @user.schedules
  end

  def show
    render json: @schedule
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      render json: @schedule
    else

      render json: { error: 'Unable to create Schedule' }, status: 400
    end
  end

  def update
    if @schedule
      @schedule.update(schedule_params)
      render json: { message: 'Schedule succesfully updated' }, status: 200
    else
      render json: { error: 'Unable to update schedule' }, status: 400
    end
  end

  def destroy
    if @schedule
      @schedule.destroy
      render json: { message: 'Schedule succesfully deleted' }, status: 200
    else
      render json: { error: 'Unable to delete Schedule' }, status: 400
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:title, :user_id, :id)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_schedule
    @schedule = Schedule.find(params[:id])
  end
end