class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :create_cart
  
  has_many :orders
  has_one :cart

  def create_cart #every user has a cart.
    check_cart = Cart.find_by(user_id: self.id)
    if check_cart.nil?
      Cart.create(user_id: self.id)
    end
  end

  # Start of adding a credit card
  
  def add_creditcard(new_card) #add new card to user billing_information
    if self.billing_information.nil? then create_cards_holder() end #the cards are stored in the card holder
    if check_card_attributes(new_card) == true then save_card(new_card) end
  end

  def create_cards_holder
    cards = Array.new
    user_billing_information = {card_holder: cards}
    self.billing_information = JSON.generate(user_billing_information)
    self.save
  end

  def check_card_attributes(new_card) # A kind of validation
    expected_keys = [:card_number, :expire_date, :security_code]
    return false unless new_card.keys == expected_keys
    if new_card.value?(nil) then return false end
    if new_card.value?("") then return false end
    return true
  end

  def save_card(new_card)
    user_billing_information = JSON.parse(self.billing_information)
    user_billing_information["card_holder"] << new_card
    self.billing_information = JSON.generate(user_billing_information)
    self.save
  end
  # End of adding of credit card
  
  # Start of adding adress
  
  def add_address(new_address)
    if self.personal_information.nil? then create_address_holder() end
    if check_address_attributes(new_address) == true then save_address(new_address) end
  end

  def create_address_holder
    user_address = {zip_code: nil, address: nil, house_number: nil, city: nil, state: nil}
    self.personal_information = JSON.generate(user_address)
    self.save
  end

  def check_address_attributes(new_address)
    expected_keys = [:zip_code, :address, :house_number, :city, :state]
    return false unless new_address.keys == expected_keys
    if new_address.value?(nil) then return false end
    if new_address.value?("") then return false end
    return true
  end

  def save_address(new_address)
    user_personal_information = JSON.parse(self.personal_information)
    user_personal_information["user_address"] = new_address
    self.personal_information = JSON.generate(user_personal_information)
    self.save
  end
  
  # End of adding address 


    
end
