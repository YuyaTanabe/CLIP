class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @friendship = Friendship.where(from_user_id: current_user.id)

    @room_invite_user_c = Room.where(invite_user_id: current_user.id)
    @room_invited_user_c = Room.where(invited_user_id: current_user.id)

    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.order(created_at: :desc).page(params[:page]).per(20)
      @message = Message.new
      @entries = @room.entries
    else
      @user = User.find_by(id: current_user.id)
      redirect_to user_path(@user.id)
      flash[:alert] = "そのページへは行けません"
    end
  end

  def create
    room = Room.new(room_params)
    entry = Entry.new(entry_params)
    user = User.find_by(id: entry.user_id)
    if current_user.have_one_friendshipID_of_the_room?(user)
      one_friendship = Friendship.find_by(from_user_id: current_user.id, to_user_id: user.id)
      one_room = Room.find_by(friendship_id: one_friendship.id)
      redirect_to room_path(one_room.id)
    elsif current_user.have_another_friendshipID_of_the_room?(user)
      another_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: current_user.id)
      another_room = Room.find_by(friendship_id: another_friendship.id)
      redirect_to room_path(another_room.id)
    else
      room.save
      entry1 = Entry.create(:room_id => room.id, :user_id => current_user.id)
      entry2 = Entry.create(:room_id => room.id, :user_id => entry.user_id)
      redirect_to room_path(room.id)
      flash[:notice] = "チャットルームを作成しました！"
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.really_destroy!
    flash[:alert] = "チャットルームを削除しました"
    redirect_to user_path(current_user)
  end

  private

  def room_params
    params.require(:room).permit(:friendship_id, :invite_user_id, :invited_user_id)
  end

  def entry_params
    params.require(:entry).permit(:room_id, :user_id)
  end

end
