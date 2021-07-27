class Api::V1::AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create 
        @user - User.find_by(email: user_login_params[:email])
        # if user is found, then given the opportunity is given to authenticate them. .authenticate comes from BCRYPT
        if @user && @user.authenticate(user_login_params[:password])
            token = encode_token({ user_id: @user.id })
            render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
        else 
            render json: { messsage: 'Invalid email or password' }, status: :unauthorized
        end 
    end

    def user_login_params
        params.require(:user).permit(:email, :password)
    end 
end
