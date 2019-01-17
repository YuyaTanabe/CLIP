class UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def clip
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :user_image, :friend_id, :email, :password, :deleted_at)
  end

end
