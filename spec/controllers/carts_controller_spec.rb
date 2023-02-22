require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :controller do
  describe 'verify if the item was added to cart' do
    context 'When user is logged in' do

      it 'it should return true if the item was added to cart' do
        buying_product = create(:product)
        user_tester = create(:user)
        Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: user_tester.cart.id)
        sign_in user_tester
        get("show", params: {user_id: user_tester.id})
        json = JSON.parse(response.body)
        expect(json["items"][0]["amount"]).to eql(2)
        expect(user_tester.cart.items.count).to eql(1)
      end

      it 'it should return true if the cart was cleaned when destroy method is called' do
        buying_product = create(:product)
        user_tester = create(:user)
        Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: user_tester.cart.id)
        sign_in user_tester
        get("show", params: {user_id: user_tester.id})
        json = JSON.parse(response.body)
        expect(json["items"][0]["amount"]).to eql(2)
        expect(user_tester.cart.items.count).to eql(1)
        delete("destroy", params: {user_id: user_tester})
        user_tester.cart.reload
        expect(user_tester.cart.items.count).to eql(0)
      end
    end
  end
end