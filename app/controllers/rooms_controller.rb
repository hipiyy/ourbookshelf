class RoomsController < ApplicationController

    def show
        @room = Room.find_by(sender_id: params[:sender_id], tweet_id: params[:id])
        @message = Message.new
        @messages = Message.where(room_id: @room.id)
    end

    def create
        tweet =  Tweet.find(params[:id])
        room = Room.new
        room.tweet_id = params[:id]
        room.sender_id = current_user.id
        room.owner_id = tweet.user_id
        room.save
        redirect_to("/rooms/#{params[:id]}/#{room.sender_id}")
    end

    def destroy
    end
end
