require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'enums' do
    let(:product_tester) {create(:product)}
    
    it 'it returns true if the enums are working correctly' do
      expect(product_tester.section).to eql("hardware")
      expect(product_tester.kind).to eql("graphic_card")
    end
  end
  describe 'creation of product stock' do #when a product is created a stock object should be created together
    let(:product_tester) {create(:product)}
    
    it 'it returns true if the stock was created sucessfully' do #this case when the product doesen't have a existing stock.
      stock_tester = Stock.find_by(product_id: product_tester.id)
      product_tester.reload
      expect(stock_tester.product_id).to eql(product_tester.id) 
    end

    it 'it returns true if the second stock wasnt created' do #each product must have only one stock.
      product_tester.create_stock
      stester = Stock.where(product_id: product_tester.id)
      expect(stester.count).to eql(1)
    end
  end

  describe 'check stock and if product is available' do #it will check if there is stock available for the product
    let(:product_tester) {create(:product)}
    
    context 'When there is not stock available' do
      it 'should return true if the item is not available' do
        product_tester.check_availability
        expect(product_tester.available).to be false
      end
    end

    context 'when there is stock available' do
      it 'should return true if the item is available' do
        product_tester.stock.update(stock_amount: 100)
        product_tester.reload
        product_tester.check_availability
        expect(product_tester.available).to be true
      end
    end
  end
end
