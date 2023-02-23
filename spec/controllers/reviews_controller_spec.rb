require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  describe 'create#method' do
    it 'it should return true if the review was created sucessfully' do
      user_tester = create(:user)
      buying_product = create(:product)
      sign_in user_tester
      review_tester = {title: "Good GPU", description: "The best gpu i've ever had", score: 5, product_id: buying_product.id, user_id: user_tester.id}
      post("create", params: {product_id: buying_product.id, review: review_tester})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      expect(buying_product.reviews.count).to eql(1)
    end
  end

  describe 'destroy#method' do
    it 'it should return true if the review was removed correctly' do
      user_tester = create(:user)
      buying_product = create(:product)
      sign_in user_tester
      review_tester = {title: "Good GPU", description: "The best gpu i've ever had", score: 5, product_id: buying_product.id, user_id: user_tester.id}
      post("create", params: {product_id: buying_product.id, review: review_tester})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      expect(buying_product.reviews.count).to eql(1)
      delete("destroy", params: {product_id: buying_product.id, id: buying_product.reviews.first.id})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was destroyed sucessfully")
      expect(buying_product.reviews.count).to eql(0)
    end
  end

  describe 'update#method' do
    it 'it should return true if the review was updated correctly' do
      user_tester = create(:user)
      buying_product = create(:product)
      sign_in user_tester
      review_tester = {title: "Good GPU", description: "The best gpu i've ever had", score: 5, product_id: buying_product.id, user_id: user_tester.id}
      post("create", params: {product_id: buying_product.id, review: review_tester})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was created sucessfully")
      expect(buying_product.reviews.count).to eql(1)
      review_tester = {title: "Amazing GPU", description: "The best gpu i've ever had", score: 5, product_id: buying_product.id, user_id: user_tester.id}
      patch("update", params: {product_id: buying_product.id, id: buying_product.reviews.first.id, review: review_tester})
      json = JSON.parse(response.body)
      expect(json["sucess"]).to eql("The review was updated sucessfully")
      review = buying_product.reviews.first
      expect(review.title).to eql("Amazing GPU")
    end
  end

end