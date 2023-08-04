require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Show Page' do
  describe 'US_4' do
    it 'displays the bulk discount quantity threshold and percentage discount' do
      bulk_discount_test_data
      visit merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
      
      expect(page).to have_content(@bulk_discount_1.id)
      expect(page).to have_content(@bulk_discount_1.quantity_threshold)
      expect(page).to have_content(@bulk_discount_1.percentage_discount)
      expect(page).to_not have_content(@bulk_discount_2.id)
      expect(page).to_not have_content(@bulk_discount_2.quantity_threshold)
      expect(page).to_not have_content(@bulk_discount_2.percentage_discount)
    end
  end
end