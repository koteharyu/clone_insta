class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(message_params)
  end

  def edit
    @message = current_user.messages.find(params[:id])
  end

  def update
    @message = current_user.messages.find(params[:id])
    @message.update(message_update_params)
  end

  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy!
  end

  private

  def message_params
    params.require(:message).permit(:body).merge(chatroom_id: params[:chatroom_id])
  end

  def message_update_params
    params.require(:message).permit(:body)
  end
end
