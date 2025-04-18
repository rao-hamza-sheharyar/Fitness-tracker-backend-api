module Api::V1
  class UsersController < ApplicationController
    before_action :authorize_request
    before_action :set_user, only: [:show, :update, :destroy]

    def index

      authorize User
      users = policy_scope(User)

      render json: users, each_serializer: ::UserSerializer
    end

    def show
      authorize @user
      render json: @user, serializer: ::UserSerializer
    end

    def update
      authorize @user
      if @user.update(user_params)
        render json: @user, serializer: ::UserSerializer
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @user
      @user.destroy
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :gender, :location, :dob, :bio, :image)
    end
  end
end
