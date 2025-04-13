module Api::V1
  class RegistrationsController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        SendConfirmationEmailJob.perform_later(user.id)
        render json: { message: "Signup successful! Please check your email to verify your account." }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def verify
      user = User.find_by(confirmation_token: params[:token])
      if user && !user.confirmed?
        user.confirm!
        render json: { message: "Email verified successfully. You can now log in." }
      else
        render json: { error: "Invalid email confirmation" }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :firstname, :lastname)
    end
  end
end
