class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(20)
  end

  def show
    @user = User.find(params[:id])
    @thing = Thing.where(user_id: @user.id).page(params[:page]).per(20)
    @location = Location.where(user_id: @user.id).page(params[:page]).per(20)
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

  def unsubscribed
    @unsubscribed_users = User.deleted.page(params[:page]).per(20)
  end

  def unsubscribed_show
    @unsubscribed_user = User.deleted.find(params[:id])
    @thing = Thing.deleted.where(user_id: @unsubscribed_user.id).page(params[:page]).per(20)
    @location = Location.deleted.where(user_id: @unsubscribed_user.id).page(params[:page]).per(20)
  end

  def revive_account
    unsubscribed_user = User.deleted.find(params[:id])
    unsubscribed_user.restore

    unsubscribed_things = Thing.deleted.where(user_id: unsubscribed_user.id)
    unsubscribed_things.each do |thing|
      thing.restore
    end

    unsubscribed_locations = Location.deleted.where(user_id: unsubscribed_user.id)
    unsubscribed_locations.each do |location|
      location.restore
    end

    unsubscribed_friendships1 = Friendship.deleted.where(to_user_id: unsubscribed_user.id)
    unsubscribed_friendships1.each do |friendship1|
      friendship1.restore
      from_user = User.deleted.find_by(id: friendship1.from_user_id)
      if from_user.present?
        friendship1.destroy
      end
    end
    unsubscribed_friendships2 = Friendship.deleted.where(from_user_id: unsubscribed_user.id)
    unsubscribed_friendships2.each do |friendship2|
      friendship2.restore
      to_user = User.deleted.find_by(id: friendship2.to_user_id)
      if to_user.present?
        friendship2.destroy
      end
    end

    unsubscribed_rooms1 = Room.deleted.where(invite_user_id: unsubscribed_user.id)
    unsubscribed_rooms1.each do |room1|
      room1.restore
      invited_user = User.deleted.find_by(id: room1.invited_user_id)
      if invited_user.present?
        room1.destroy
      else
        unsubscribed_messages = Message.deleted.where(room_id: room1.id)
        unsubscribed_messages.each do |message|
          message.restore
        end
        unsubscribed_entries = Entry.deleted.where(room_id: room1.id)
        unsubscribed_entries.each do |entry|
          entry.restore
        end
      end
    end
    unsubscribed_rooms2 = Room.deleted.where(invited_user_id: unsubscribed_user.id)
    unsubscribed_rooms2.each do |room2|
      room2.restore
      invite_user = User.deleted.find_by(id: room2.invite_user_id)
      if invite_user.present?
        room2.destroy
      else
        unsubscribed_messages = Message.deleted.where(room_id: room2.id)
        unsubscribed_messages.each do |message|
          message.restore
        end
        unsubscribed_entries = Entry.deleted.where(room_id: room2.id)
        unsubscribed_entries.each do |entry|
          entry.restore
        end
      end
    end

    flash[:notice] = unsubscribed_user.user_name + "のアカウント情報を復元しました。"
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
