require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "After creation" do
    before :each do
      @category = Category.create(name: "Shoes")
      @product1 = Product.create!(name: "flip flops", price_cents: 999, quantity: 10, category_id: @category.id)
      @product2 = Product.create!(name: "alarm clock", price_cents: 999, quantity: 8, category_id: @category.id)
    end
    it 'deducts quantity from products based on their line item quantities' do
      @order = Order.new(
        email: 'natasha@gmail.com',
        total_cents: 999,
        stripe_charge_id: 1111
      )
    
     
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
      )


      @product1.reload
      @product2.reload

      expect(@product1.quantity).to eq(8)
      expect(@product2.quantity).to eq(8)



    end
    it "doesn't deduct quantity from products based on their line item quantities" do
      @order = Order.new(
        email: 'natasha@gmail.com',
        total_cents: 999,
        stripe_charge_id: 1111
      )
    
     
      @order.line_items.new(
        product: @product1,
        quantity: 2,
        item_price: @product1.price,
        total_price: @product1.price * 2
      )

      @order.save!

      @product1.reload
      @product2.reload

      expect(@product1.quantity).to eq(8)
      
      expect(@product2.quantity).to eq(8)

    end
  end
end

def create_order(stripe_charge)
  order = Order.new(
    email: params[:stripeEmail],
    total_cents: cart_subtotal_cents,
    stripe_charge_id: stripe_charge.id, # returned by stripe
  )

  enhanced_cart.each do |entry|
    product = entry[:product]
    quantity = entry[:quantity]
    order.line_items.new(
      product: product,
      quantity: quantity,
      item_price: product.price,
      total_price: product.price * quantity
    )
  end
  order.save!
  order
end