module Api
  module V1
    class FinancesController < ApplicationController
      before_action :authenticate_user!
      before_action :check_admin

      def show
        finance = Finance.first
        finance.start_calculations
        render json: FinanceSerializer.new(finance, {include: :orders}).serializable_hash
      end
    end
  end
end