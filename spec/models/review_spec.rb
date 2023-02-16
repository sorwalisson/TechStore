require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    let(:buying_product) {create(:product)}
    let(:user_tester) {create(:user)}

    it 'it should return true if the review meets the requirements' do
      Review.create(title: "good graphic card", description: "it is better than i expected good framerates", score: 5, product_id: buying_product.id, user_id: user_tester.id)
      expect(buying_product.reviews.count).to eql(1)
    end

    it 'it should return true if the review does not meet the requirements' do
      Review.create(title: "good graphic card", score: 5, product_id: buying_product.id, user_id: user_tester.id)
      expect(buying_product.reviews.count).to eql(0)
    end

  end
end
