require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Calculation of total_price' do
    let(:user_tester) {create(:user)}
    let(:buying_product) {create(:product)}
    let(:finance_tester) {create(:finance)}
    let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0)}

    context 'when there is only one item' do
      it 'it returns true if the calculation is correct' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.calculate_total_price
        order_tester.reload
        expect(order_tester.total_price).to eql(8000.0)
      end
    end

    context 'when there is more than one item' do
      let(:second_product) {Product.create(name: "i7", price: 1700)}
      
      it 'it should return true if the value is correct' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        item_tester2 = Item.create(amount: 1, product_id: second_product.id, sellable_type: "Order", sellable_id: order_tester.id)

        order_tester.calculate_total_price
        order_tester.reload
        expect(order_tester.total_price).to eql(9700.0)
      end
    end

  end

  describe 'Calculate total_tax' do
    let(:user_tester) {create(:user)}
    let(:buying_product) {create(:product)}
    let(:finance_tester) {create(:finance)}
    let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0)}

    context 'when there is only one item' do
      it 'it should return true if the tax value was calculated correctly' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.calculate_total_tax
        order_tester.reload
        expect(order_tester.tax_amout).to eql(1200.0)
      end
    end

    context 'when there is more than one item' do
      let(:second_product) {Product.create(name: "i7", price: 2700, cost: 1500, product_tax: 50)}
      
      it 'it should return true if the calculation was done correctly' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        item_tester2 = Item.create(amount: 1, product_id: second_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.calculate_total_tax
        order_tester.reload
        expect(order_tester.tax_amout).to eql(1950.0)
      end
    end
  end
  
  describe 'Calculate total_cost' do
    let(:user_tester) {create(:user)}
    let(:buying_product) {create(:product)}
    let(:finance_tester) {create(:finance)}
    let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0)}

    context 'when there is only one item' do
      it 'it should return true if the cost was calculated correctly' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.calculate_total_cost
        order_tester.reload
        expect(order_tester.total_cost).to eql(4000.0)
      end
    end
    
    context 'when there is more than one item' do
      let(:second_product) {Product.create(name: "i7", price: 2700, cost: 1500, product_tax: 50)}
      
      it 'it should return true if the calculation was done correctly' do
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        item_tester2 = Item.create(amount: 1, product_id: second_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.calculate_total_cost
        order_tester.reload
        expect(order_tester.total_cost).to eql(5500.0)
      end
    end
  end

  describe 'cancel order' do
    let(:user_tester) {create(:user)}
    let(:buying_product) {create(:product)}
    let(:finance_tester) {create(:finance)}
    let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0, status: "open")}

    context 'when the order is sucessfully canceled' do
      it 'should return true if the order was cancelled sucessfully' do
        Stock.find_by(product_id: buying_product.id).update(stock_amount: 10)
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.reload
        order_tester.cancel_order
        order_tester.reload
        expect(Stock.find_by(product_id: buying_product.id).stock_amount).to eql(12)
        expect(order_tester.status).to eql("cancelled")
      end
    end

    context 'When the order is not sucessful due to restriction' do
      it 'should return true if the order was not cancelled' do
        order_tester.update(status: "paid")
        Stock.find_by(product_id: buying_product.id).update(stock_amount: 10)
        item_tester = Item.create(amount: 2, product_id: buying_product.id, sellable_type: "Order", sellable_id: order_tester.id)
        order_tester.reload
        order_tester.cancel_order
        order_tester.reload
        expect(order_tester.status).to eql("paid")
        expect(Stock.find_by(product_id: buying_product.id).stock_amount).to eql(10)
      end
    end
  end
end
