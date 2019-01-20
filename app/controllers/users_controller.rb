class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    if current_user.is_friend?(@user)
      @thing_public = Thing.where(user_id: @user.id, public_status: 2)
      @location_public = Location.where(user_id: @user.id, public_status: 2)
      @friendship = Friendship.find_by(to_user_id: @user.id)
      @room = Room.new
      @entry = Entry.new
    elsif current_user.id == @user.id
      @thing = Thing.where(user_id: @user.id)
      @location = Location.where(user_id: @user.id)
      @entries = current_user.entries
    else
      flash[:alert] = "そのユーザーとはフレンドではないためそのページへは行けません"
      redirect_to user_path(current_user.id)
    end
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
