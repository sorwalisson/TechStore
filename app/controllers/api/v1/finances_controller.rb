module Api
  module V1
    class FinancesController < ApplicationController
      before_action :authenticate_user!
      before_action :check_admin

      def index
        finance = Finance.first
        render json: FinanceSerializer.new(finance, {include: :orders.where(status: "done")}).serializable_hash
      end
    end
  end
end