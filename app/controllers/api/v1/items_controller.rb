module Api
  module V1
    class ItemsController < ApplicationController
      before_action :authenticate_user!
      before_action :cart_item_checker(params[:id])
      def show
        item = Item.find_by(id: params[:id])
        render :json => item, each_serializer: ItemSerializer
      end

      def destroy
        item = Item.find_by(id: params[:id])
        if cart_item_checker(item.id) == true
          item.destroy
          render json: {sucess: "The item was destroyed sucessfully"}
        else
          render json: {sucess: "The item cannot be destroyed because it belongs to a order"}
        end
      end
    end
  end
end