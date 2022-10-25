require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new(name: 'XL')
    @category.save!
    @product = Product.new(name: 'Jurassic Plant', price: 199, quantity: 25, category: @category)
  end

  describe 'Validations' do
    it 'should save when all 4 fields are set properly' do
      @product.save!
      expect(@product).to be_valid
    end

    it 'should not save if name is nil' do
      @product.name = nil
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages[0]).to eq('Name can\'t be blank')
    end

    it 'should not save if price is nil' do
      @product.price_cents = nil
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages[0]).to eq('Price cents is not a number')
    end

    it 'should not save if quantity is nil' do
      @product.quantity = nil
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages[0]).to eq('Quantity can\'t be blank')
    end

    it 'should not save if category is nil' do
      @product.category = nil
      expect { @product.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(@product.errors.full_messages[0]).to eq('Category must exist')
    end
  end
end
