module Api
  module V1
    class AddersController < ApplicationController
      before_action :authenticate_user!
      def create
        selected_item = params[:product_id]
        selected_amount = params[:amount].to_i
        if selected_amount == nil then selected_amount = 1 end
        if current_user.add_item_to_cart(selected_item, selected_amount)
          render json: {sucess: "The item was added to your cart sucessfully"}
        else
          render json: {error: "Unknown Error"}
        end
      end
    end
  end
end