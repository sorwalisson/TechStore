class Product < ApplicationRecord
  has_one :stock, dependent: :destroy
  has_many :reviews

  enum section: {hardware: 0, peripherals: 1, consoles: 2, furniture: 3, computers: 4, accessories: 5}
  enum kind: {processor: 0, graphic_card: 1, power_supply: 2, rams: 3, hard_drive: 4, ssds: 5, coolers: 6, fans: 7, headset_and_microphones: 8, keyboards: 9, mouse: 10, monitors: 11, games: 12, gaming_chair: 13, desks: 14, gaming_pc: 15, workstation: 16, cables: 17, decoration: 18}
  after_create :create_stock
  
  #Scopes
  
  #Methods
  
  def avg_score
    reviews.average(:score).to_f
  end

  def create_stock #this method will be called whenever a new product is created to created.
    check_stock = Stock.find_by(product_id: self.id)
    if check_stock == nil
      Stock.create(product_id: self.id, stock_amount: 0, sold_amount: 0)
    end
  end

  def check_availability #the product is available when there is stock to be sold
    if self.stock.stock_amount > 0
      self.available = true
    else
      self.available = false
    end
  end


end
