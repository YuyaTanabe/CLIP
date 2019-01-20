class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if Entry.where(user_id: current_user.id, room_id: message.room_id).present?
      message.user_id = current_user.id
      message.save
      redirect_to room_path(message.room_id)
    else
      @user = User.find_by(id: current_user.id)
      redirect_to user_path(@user.id)
      flash[:alert] = "そのチャットルームではメッセージを送れません"
    end
  end

  def edit
    @message = Message.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @message.room_id).present?
    else
      @user = User.find_by(id: current_user.id)
      redirect_to user_path(@user.id)
      flash[:alert] = "そのチャットルームではメッセージを送れません"
    end
  end

  def update
    message = Message.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: message.room_id).present?
      message.update(message_params)
      flash[:notice] = "メッセージを編集しました"
      redirect_to room_path(message.room_id)
    else
      flash[:alert] = "そのページへは行けません"
      redirect_to user_path(current_user.id)
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.destroy
    flash[:alert] = "メッセージを削除しました"
    redirect_to room_path(message.room_id)
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end

end
