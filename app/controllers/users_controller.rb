class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @thing = Thing.where(user_id: @user.id)
    @thing_public = Thing.where(user_id: @user.id, public_status: 2)
    @location = Location.where(user_id: @user.id)
    @location_public = Location.where(user_id: @user.id, public_status: 2)
    @friendship = Friendship.find_by(to_user_id: @user.id)
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
    params.require(:user).permit(
      :user_name,
      :user_image,
      :friend_id,
      :email,
      :password,
      :deleted_at
    )
  end

end
