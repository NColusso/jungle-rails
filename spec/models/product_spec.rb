require 'rails_helper'
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

RSpec.describe Product, type: :model do
  describe "Validations" do
    it "will save successfully if all fields are present" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "flip flops", price_cents: 999, quantity: 10, category_id: @category.id)
      
      expect(@product.errors).to be_empty
    end

    it "validates the name is present" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: nil, price_cents: 999, quantity: 10, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Name can't be blank")

    end
    
    it "validates the price is present" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "flip flops", price_cents: nil, quantity: 10, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it "validates the quantity is present" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "flip flops", price_cents: 999, quantity: nil, category_id: @category.id)

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "validates the category is present" do
      @category = Category.create(name: "Shoes")
      @product = Product.create(name: "flip flops", price_cents: 999, quantity: 10, category_id: nil)

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
