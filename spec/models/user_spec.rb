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

  describe 'add billing_information' do
    let(:user_tester) {create(:user)}

    context 'when the user fills the form correctly' do
      it 'it should return true if the the card was addes to billing_information' do
        new_card = {card_number: "000000000000", expire_date: "00/00", security_code: "000"}
        user_tester.add_creditcard(new_card)
        user_tester.reload
        json = JSON.parse(user_tester.billing_information)
        expect(json["card_holder"][0]["card_number"]).to eql("000000000000")
      end
    end

    context 'when the user does not fill the form correctly' do
      it 'it should return true if the card wasnt saved' do
        new_card = {card_number: "000000000000", expire_date: "00/00"}
        user_tester.add_creditcard(new_card)
        user_tester.reload
        json = JSON.parse(user_tester.billing_information)
        expect(json["card_holder"]).to be_empty
      end
    end
  end

  describe 'add personal_information' do
    let(:user_tester) {create(:user)}

    context 'when the user fills address correctly' do
      it 'should return if the address was added correctly' do
        new_address = {zip_code: "000000", address: "street 1", house_number: "235", city: "Somewhere" , state: "nearby"}
        user_tester.add_address(new_address)
        user_tester.reload
        json = JSON.parse(user_tester.personal_information)
        
        expect(json["user_address"]["zip_code"]).to eql("000000")
        expect(json["user_address"]["address"]).to eql("street 1")
        expect(json["user_address"]["house_number"]).to eql("235")
        expect(json["user_address"]["city"]).to eql("Somewhere")
        expect(json["user_address"]["state"]).to eql("nearby")
      end
    end

    context 'when the user fills address incorrectly' do
      it 'should return true if the address was not added' do
        new_address = {zip_code: "000000", address: "street 1", house_number: "235", city: "Somewhere"}
        user_tester.add_address(new_address)
        user_tester.reload
        json = JSON.parse(user_tester.personal_information)
        expect(json["user_address"]).to be nil
      end
    end
  end
end
