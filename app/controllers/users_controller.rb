class UsersController < ApplicationController
    def show
        @user = User.find(params[:id]) 
        @roomssender = Room.where(sender_id:@user.id)
        @roomsowner = Room.where(owner_id:@user.id)

    end
end