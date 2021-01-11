class MessagesController < ApplicationController

    def create
        
        message = Message.new(message_params)
        message.user_id = current_user.id
        message.room_id = params[:id] #params[:id] は@tweet.idではダメ
        message.save
        room = Room.find(message.room_id)
        redirect_to("/rooms/#{params[:tweet_id]}/#{room.sender_id}")
        
    end

    def destroy
    end
    private
    def message_params
        params.require(:message).permit(:body)
    end
end
