require 'rails_helper'

RSpec.describe Stock, type: :model do
  describe 'add batch to product' do
    let(:buying_product) {create(:product)}
    let(:stock_tester) {Stock.find_by(product_id: buying_product.id)}

    it 'it should return true if the batch was added sucessfully' do
      amount_product = 230
      stock_tester.update(stock_amount: 5)
      stock_tester.add_batch(amount_product)
      stock_tester.reload
      expect(stock_tester.stock_amount).to eql(5 + amount_product)
    end
  end

  describe 'subtract the amount of item sold from stock' do
    let(:buying_product) {create(:product)}
    let(:stock_tester) {Stock.find_by(product_id: buying_product.id)}

    it 'it should return true if the amount was subtracted sucessfully' do
      stock_tester.update(stock_amount: 5)
      stock_tester.subtract_item(3)
      stock_tester.reload
      expect(stock_tester.stock_amount).to eql(2)
    end
  end

  describe 'add the amount of item sold to sold amount' do
    let(:buying_product) {create(:product)}
    let(:stock_tester) {Stock.find_by(product_id: buying_product.id)}

    it 'it should return true if the amount was added sucessfully' do
      stock_tester.update(sold_amount: 5)
      stock_tester.add_sold_amount(3)
      stock_tester.reload
      expect(stock_tester.sold_amount).to eql(8)
    end
  end
end
