require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  describe '#show' do
    context 'when used for carts' do
      it 'should return true if the show method is working perfectly' do  
        buying_product = create(:product)
        user_tester = create(:user)
        item_tester = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: user_tester.cart.id)
        sign_in user_tester
        get("show", params: {user_id: user_tester.id, id: item_tester.id})
        json = JSON.parse(response.body)
        expect(json["amount"]).to eql(2)
        expect(json["product_id"]).to eql(buying_product.id)
      end
    end
  end

  describe '#destroy' do
    context 'when used for carts' do
      it 'should return true if the item was destroyed sucessfully' do
        buying_product = create(:product)
        user_tester = create(:user)
        item_tester = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: user_tester.cart.id)
        sign_in user_tester
        get("show", params: {user_id: user_tester.id, id: item_tester.id})
        json = JSON.parse(response.body)
        expect(json["amount"]).to eql(2)
        expect(json["product_id"]).to eql(buying_product.id)
        delete("destroy", params: {user_id: user_tester.id, id: item_tester.id})
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("The item was destroyed sucessfully")
        expect(user_tester.cart.items.count).to eql(0)
      end
    end
  end
end