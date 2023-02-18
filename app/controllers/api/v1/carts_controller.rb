module Api
  module V1
    class CartsController < ApplicationController
      before_action :authenticate_user!

      def index
        cart = Cart.find_by(user_id: current_user.id)
        render json: ItemSerializer.new(cart, {include: :items}).serializable_hash
      end

      def destroy
        cart = Cart.find_by(user_id: current_user.id)
        cart.clean_cart()
        render json: {sucess: "The cart was clean sucessfully"}
    end
  end
end