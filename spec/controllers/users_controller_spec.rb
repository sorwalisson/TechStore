require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'index' do
    it 'should return true if the index method is working' do
      user_tester = create(:user)
      sign_in user_tester
      get("show", params: {id: user_tester.id})
      json = JSON.parse(response.body)
      expect(json["name"]).to eql("Peter Griffin")
    end
  end


end