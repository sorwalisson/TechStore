require 'rails_helper'

RSpec.describe Api::V1::AddersController, type: :controller do
  describe 'Add Item to user carts' do 
    let(:buying_product) {create(:product)}
    context 'When user is logged in' do

      it 'it should return true if the item was added to cart' do
        user_tester = create(:user)
        sign_in user_tester
        post("create", params: {product_id: buying_product.id})
        user_tester.cart.reload
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("The item was added to your cart sucessfully")
        expect(user_tester.cart.items.count).to eql(1)
      end
      it 'it shoudl return true if the item was added to cart and the amounts was added' do
        buying_product = create(:product)
        user_tester = create(:user)
        sign_in user_tester
        post("create", params: {product_id: buying_product, amount: "2"})
        user_tester.cart.reload
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("The item was added to your cart sucessfully")
        expect(user_tester.cart.items.count).to eql(1)
        expect(user_tester.cart.total).to eql(8000.0)
      end
    end
  end
end
