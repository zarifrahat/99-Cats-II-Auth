class UsersController < ApplicationController
    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        @user.password=(@user[:password])
        @user.session_token = User.reset_session_token!
        if @user.save
            redirect_to cats_url
        else
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end 

end