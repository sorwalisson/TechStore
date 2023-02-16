module Api
  module V1
    class ProductsController < ApplicationController
      before_action :authenticate_user!, only: [:create, :update, :destroy]
      before_action :check_admin, except: [:index, :show]

      def index
        products = ProductsQuery.new(params: params[:query]).call
        return render json: {error: "No product found!"}, status: 442 unless products.exists?
        render :json => products, each_serializer: ProductSerializer
      end

      def show
        product = Product.find_by(id: params[:id])
        return render json: {error: "No product found!"}, status: 442 unless title != nil
        render json: ProductSerializer.new(product, {include: :reviews}).serializable_hash
      end

      def create
        product = Product.create(product_params)
        if product.valid?
          render json: {sucess: "the product was added sucessfully"}
        else
          render json: {error: "the product is missing some important information"}
        end
      end

      def update
        product = Product.find_by(id: params[:id])
        if product.update(product_params)
          render json: {sucess: "the product was updated sucessfully"}
        else
          render json: {error: "the product wasnt updated due to the lack of importante information"}
        end
      end

      def destroy
        product = Product.find_by(id: params[:id])
        if product.destroy then render json: {sucess: "the product was destroyed sucessfully"} end
      end

      private

      def product_params
        params.require(:product).permit(:name, :brand, :section, :image_url, :cost, :kind, :price, :general_information)
      end
    end
  end
end
