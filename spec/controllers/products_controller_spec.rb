require 'rails_helper'

RSpec.describe Api::V1::ProductsController, :type => :controller do
  describe 'verify is the user is admin to access actions that requires admins' do
    context 'user is admin' do
      
      it 'it should return true if the user was able to create the product sucessfully' do #it also serves as a tester fo create method
        cecilia = create(:user, admin: true)
        sign_in cecilia
        params = {name: "testing", brand: "testing"}
        post("create", params: {product: params})
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("the product was added sucessfully")
        expect(Product.count).to eql(1)
      end

      it 'it shoudl return true if the product was updated sucessfully' do #it also serves the purpose of an #update methoc test
        cecilia = create(:user, admin: true)
        sign_in cecilia
        params = {name: "testing", brand: "testing"}
        post("create", params: {product: params})
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("the product was added sucessfully")
        expect(Product.count).to eql(1)
        update_tester = Product.first
        patch("update", params: {id: update_tester.id, product: {name: "RTX 4090"}})
        update_tester.reload
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("the product was updated sucessfully")
        expect(update_tester.name).to eql("RTX 4090")
      end

      it 'it should return true if the product was destroyed sucessfully' do #it also serves the purpose of a #destroy method test
        cecilia = create(:user, admin: true)
        sign_in cecilia
        tester = create(:product)
        delete("destroy", params: {id: tester.id})
        json = JSON.parse(response.body)
        expect(json["sucess"]).to eql("the product was destroyed sucessfully")
      end
    end

    context 'when user is not admin' do
      it 'it shoudl return true if the user cannot access private admin sections' do
        cecilia = create(:user, admin: false)
        sign_in cecilia
        params = {name: "testing", brand: "testing"}
        post("create", params: {product: params})
        json = JSON.parse(response.body)
        expect(json["error"]).to eql("Only admins may access this fuction")
        expect(Product.count).to eql(0)
      end
    end
  end

  describe 'verify action #index' do
    
    context 'if no filter query applied' do
      it 'should return true if the index mthod is working correctly' do
        create(:product)
        get("index")
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eql("RTX 4070")
      end
    end

    context 'if the filter is applied and there is a product with the charactestics' do
      it 'should return true if the product was displayed' do
        tester = create(:product)
        params = {query: tester.section}
        get("index", params: params)
        json = JSON.parse(response.body)
        expect(json[0]["name"]).to eql("RTX 4070")
      end
    end

    context 'if there is not a product with the params' do
      it 'should return true if no item was found' do
        tester = create(:product)
        params = {query: "peripherals"}
        get("index", params: params)
        json = JSON.parse(response.body)
        expect(json["error"]).to eql("No product found!")
      end
    end
  end
end
 