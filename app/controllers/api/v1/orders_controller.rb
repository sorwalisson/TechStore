module Api
  module V1
    class OrdersController < ApplicationController
      before_action :authenticate_user!
      def index
        orders = Order.where(user_id: current_user.id)
        orders.each do |order|
          order.start_order_calculations
        end
        render :json => orders, each_serializer: OrderSerializer
      end

      def show
        order = Order.find_by(id: params[:id])
        order.start_order_calculations
        return render json: {error: "No order found!"} unless order != nil
        render json: OrderSerializer.new(order, {include: :items}).serializable_hash
      end

    end
  end
end