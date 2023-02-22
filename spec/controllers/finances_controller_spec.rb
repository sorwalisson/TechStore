require 'rails_helper'

RSpec.describe Api::V1::FinancesController, type: :controller do
  describe '#index' do
    it 'it returns true if the index methods is working' do
      user_tester = create(:user, admin: true)
      buying_product = create(:product)
      finance_tester = Finance.create
      order_tester = Order.create(finance_id: finance_tester.id, user_id: user_tester.id, status: "done", shipping_cost: 0)
      item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
      sign_in user_tester
      order_tester.start_order_calculations
      order_tester.reload
      get("show")
      json = JSON.parse(response.body)
      expect(json["orders"][0]["total_price"]).to eql(8000.0)
    end
    it 'it should return true if the index is ignoring not done orders' do
      user_tester = create(:user, admin: true)
      buying_product = create(:product)
      finance_tester = Finance.create
      order_tester = Order.create(finance_id: finance_tester.id, user_id: user_tester.id, status: "awaiting_payment", shipping_cost: 0)
      item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
      sign_in user_tester
      order_tester.start_order_calculations
      order_tester.reload
      get("show")
      json = JSON.parse(response.body)
      expect(json["orders"]).to be_empty
    end
  end
end

