class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user.is_friend?(@user)
      @thing_public = Thing.where(user_id: @user.id, public_status: 2).page(params[:page]).per(20)
      @location_public = Location.where(user_id: @user.id, public_status: 2).page(params[:page]).per(20)
      @friendship = Friendship.find_by(to_user_id: @user.id)
      @room = Room.new
      @entry = Entry.new
    elsif current_user.id == @user.id
      @thing = Thing.where(user_id: @user.id).page(params[:page]).per(20)
      @location = Location.where(user_id: @user.id).page(params[:page]).per(20)
      @entries = current_user.entries
    else
      flash[:alert] = "そのユーザーとはフレンドではないためそのページへは行けません。"
      redirect_to user_path(current_user.id)
    end
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      flash[:alert] = "そのページへは行けません。"
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = @user.user_name + "のアカウント情報を編集しました。"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:alert] = user.user_name + "のアカウント情報を削除しました。"
    redirect_to root_path
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
