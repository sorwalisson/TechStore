require 'rails_helper'

RSpec.describe Finance, type: :model do
  describe 'check if the calculations are correct' do # this block will calculate all attribuites because they come from the same source.

    context 'Check if it is working with only one order' do
      let(:user_tester) {create(:user)}
      let(:buying_product) {create(:product)}
      let(:finance_tester) {create(:finance)}
      let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0)}

      it 'should return true if the finance are only calculating orders that are done' do # To values be calculated the orders should be done.
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Order", sellable_id: order_tester.id)
        finance_tester.start_calculations
        
        expect(finance_tester.gross_income).to eql(0.0)
        expect(finance_tester.net_profit).to eql(0.0)
        expect(finance_tester.expenses).to eql(0.0)
        expect(finance_tester.tax_amount).to eql(0.0)
      end

      it 'should return true if the finance are calculating the attributes correctly' do
        #set item
        @item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Order", sellable_id: order_tester.id)
        #start order cal
        order_tester.start_order_calculations
        order_tester.update(status: "done")
        #start finance cal
        finance_tester.start_calculations
        finance_tester.reload
        
        expect(finance_tester.gross_income).to eql(8000.0)
        expect(finance_tester.net_profit).to eql(2800.0)
        expect(finance_tester.expenses).to eql(4000.0)
        expect(finance_tester.tax_amount).to eql(1200.0)
      end
    end

    context 'check if it is working with more than 2 orders' do
      let(:user_tester) {create(:user)}
      let(:buying_product) {create(:product)}
      let(:finance_tester) {create(:finance)}
      let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0)}
      let(:second_product) {Product.create(name: "i7", price: 2700, cost: 1500, product_tax: 50)}
      let(:third_product) {Product.create(name: "Corsair 3333 mhz ram", price: 450, cost: 230, product_tax: 30)}
      
      it 'should return true if the finance are calculating the attributes correctly' do
        #set items
        item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Order", sellable_id: order_tester.id)
        item2 = Item.create(product_id: second_product.id, amount: 3, sellable_type: "Order", sellable_id: order_tester.id)
        item3 = Item.create(product_id: third_product.id, amount: 4, sellable_type: "Order", sellable_id: order_tester.id)
        #order cal
        order_tester.start_order_calculations
        order_tester.update(status: "done")
        #finance cal
        finance_tester.start_calculations
        finance_tester.reload
        
        expect(finance_tester.gross_income).to eql(17900.0)
        expect(finance_tester.net_profit).to eql(4754.0)
        expect(finance_tester.expenses).to eql(9420.0)
        expect(finance_tester.tax_amount).to eql(3726.0)
      end
    end

    context 'adding value to a finance that alrady has value on it' do
      let(:user_tester) {create(:user)}
      let(:buying_product) {create(:product)}
      let(:finance_tester) {create(:finance, gross_income: 10000, expenses: 5000, tax_amount: 3000, net_profit: 2000)}
      let(:order_tester) {Order.create(user_id: user_tester.id, finance_id: finance_tester.id, shipping_cost: 0, status: "arrived")}

      it 'it should return true if the values were added correctly' do
        item = Item.create(product_id: buying_product.id, amount: 2, sellable_type: "Order", sellable_id: order_tester.id)
        
        order_tester.change_status("done")
        order_tester.reload
        
        finance_tester.reload
        
        expect(finance_tester.gross_income).to eql(18000.0)
        expect(finance_tester.expenses).to eql(9000.0)
        expect(finance_tester.tax_amount).to eql(4200.0)
        expect(finance_tester.net_profit).to eql(4800.0)
      end
    end
  end
end

