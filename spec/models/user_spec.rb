require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create_cart' do
    let(:user_tester) {create(:user)}

    it 'it should return true if the cart was created' do
      cart_tester = Cart.find_by(user_id: user_tester.id)
      expect(cart_tester.user_id).to eql(user_tester.id)
    end

    it 'it should return true if the user only has one cart' do #every user should have only one cart, this will test if the code prevents a second one from being created.
      user_tester.create_cart
      user_tester.reload
      counter = Cart.where(user_id: user_tester.id)
      expect(counter.count).to eql(1)
    end
  end
end
