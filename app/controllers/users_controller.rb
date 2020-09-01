class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ['Users not found']
      }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: {
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: ['User not found']
      }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!
      render json: {
        status: :created,
        user: @user
      }
    else
      render json: {
        status: 500,
        errors: @user.errors.full_messages
      }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user
      @user.update(user_params)
      render json: { message: 'Profile succesfully updated' }, status: 200
    else

      render json: { error: 'Unable to update Profile' }, status: 400
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user
      @user.destroy
      render json: { message: 'Profile succesfully deleted' }, status: 200
    else

      render json: { error: 'Unable to delete Profile' }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
