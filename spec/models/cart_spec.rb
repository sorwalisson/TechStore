require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'check if the total sum is working' do
    let(:user_tester) {create(:user)}
    let(:mario_cart) {Cart.find_by(user_id: user_tester.id)}
    let(:buying_product) {create(:product)}
    
    context 'this case for one product but more than 1 amount' do
      it 'it should return true if it is working properly' do
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: mario_cart.id)
        mario_cart.calculate_total
        mario_cart.reload
        expect(mario_cart.total).to eql(8000.0)
      end
    end

    context 'this case for more than one item' do
      let(:second_product) {Product.create(name: "CPU i7", price: 2300)}
      
      it 'it shoudl return true if the calculation is correct.' do
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: mario_cart.id)
        @item2 = Item.create(product_id: second_product.id, amount: 1, sellable_type: "Cart", sellable_id: mario_cart.id)
        mario_cart.calculate_total
        mario_cart.reload
        expect(mario_cart.total).to eql(10300.0)
      end
    end
  end

  describe 'check if exchange from cart to order is working' do
    let(:user_tester) {create(:user)}
    let(:mario_cart) {Cart.find_by(user_id: user_tester.id)}
    let(:buying_product) {create(:product)}
    let(:finance_tester) {create(:finance)}

    context 'when there is one item on the cart' do
      it 'it should return true if the order was created and items now belongs to it' do
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: mario_cart.id)
        mario_cart.create_order(user_tester.id, finance_tester.id)
        order_tester = Order.find_by(user_id: user_tester.id)
        expect(order_tester.items.count).to eql(1)
        expect(mario_cart.items.count).to eql(0)
      end
    end

    context 'when there is more than one item at the cart' do
      let(:second_product) {Product.create(name: "CPU i7", price: 2300)}

      it 'it should return true if the order was created and items now belongs to it' do
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Cart", sellable_id: mario_cart.id)
        @item2 = Item.create(product_id: second_product.id, amount: 1, sellable_type: "Cart", sellable_id: mario_cart.id)
        mario_cart.create_order(user_tester.id, finance_tester.id)
        order_tester = Order.find_by(user_id: user_tester.id)
        expect(order_tester.items.count).to eql(2)
        expect(mario_cart.items.count).to eql(0)
      end
    end
  end

  describe 'add_item to cart' do
    let(:user_tester) {create(:user)}
    let(:mario_cart) {Cart.find_by(user_id: user_tester.id)}
    let(:buying_product) {create(:product)}
    
    it 'it returns true if the item was added sucessfully when the item is not present at the cart' do
      mario_cart.add_item(buying_product.id, 2)
      mario_cart.reload
      expect(mario_cart.items.count).to eql(1)
      expect(mario_cart.total).to eql(8000.0)
    end

    it 'it should return true if the item amount was added sucessfully to the existing item.' do
      mario_cart.add_item(buying_product.id, 2)
      mario_cart.reload
      expect(mario_cart.items.count).to eql(1)
      expect(mario_cart.total).to eql(8000.0)
      mario_cart.add_item(buying_product.id, 2)
      mario_cart.reload
      expect(mario_cart.items.count).to eql(1)
      expect(mario_cart.total).to eql(16000.0)
    end
  end

  describe 'destroy_item' do
    let(:user_tester) {create(:user)}
    let(:mario_cart) {Cart.find_by(user_id: user_tester.id)}
    let(:buying_product) {create(:product)}

    it 'it should return true iof the item was destroyed sucessfully' do
      mario_cart.add_item(buying_product.id, 2)
      mario_cart.reload
      expect(mario_cart.items.count).to eql(1)
      expect(mario_cart.total).to eql(8000.0)
      
      @item = Item.first
      mario_cart.exclude_item(@item.id)
      mario_cart.reload
      expect(mario_cart.items.count).to eql(0)
      expect(mario_cart.total).to eql(0.0)
    end
  end
end
