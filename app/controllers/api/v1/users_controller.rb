module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def index
        user = User.find_by(id: current_user.id)
        render :json => user, each_serializer: UserSerializer
      end
    end
  end
end