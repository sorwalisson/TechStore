require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'index#method' do
    it 'it returns true if the index method is working' do
      user_tester = create(:user, admin: true)
      buying_product = create(:product)
      finance_tester = Finance.create
      order_tester = Order.create(finance_id: finance_tester.id, user_id: user_tester.id, status: "done", shipping_cost: 0)
      item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
      sign_in user_tester
      order_tester.start_order_calculations
      order_tester.reload
      get("index", params: {user_id: user_tester.id})
      json = JSON.parse(response.body)
      expect(json[0]["items"][0]["amount"]).to eql(item_tester.amount)
    end
  end

  describe 'show#method' do
    it 'it returns true if the show method is working' do
      user_tester = create(:user, admin: true)
      buying_product = create(:product)
      finance_tester = Finance.create
      order_tester = Order.create(finance_id: finance_tester.id, user_id: user_tester.id, status: "done", shipping_cost: 0)
      item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
      sign_in user_tester
      order_tester.start_order_calculations
      order_tester.reload
      get("show", params: {user_id: user_tester.id, id: order_tester.id})
      json = JSON.parse(response.body)
      expect(json["total_price"]).to eql(8000.0)
    end
  end

end