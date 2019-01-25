class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @thing = Thing.where(user_id: @user.id)
    @location = Location.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = @user.user_name + "のアカウント情報を編集しました。"
      redirect_to admins_user_path(@user.id)
    else
      render "edit"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:alert] = user.user_name + "のアカウント情報を削除しました。"
    redirect_to admins_users_path
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
