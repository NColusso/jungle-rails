class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :update_quantity

  def update_quantity
    p self
    @line_items = LineItem.where(order_id: self.id)
    @line_items.each do |item|
      @product = Product.find(item.product_id)
      puts 'product:'
      p @product
      puts 'old quantity:'
      @product_prev_quantity = @product.quantity
      puts @product_prev_quantity
      puts "quantity ordered:"
      puts item.quantity
      @product.quantity = @product_prev_quantity - item.quantity
      @product.save
      p @product.quantity
     

    end
  end

end
