module Api::V1
  class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])

        token = JsonWebToken.encode({ user_id: user.id, role: user.role })
        render json: user, serializer: ::UserSerializer, meta: { token: token }
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
end