require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index Page' do
  describe "US_1 (pt 2)" do 
    it 'displays all bulk discounts with percentage of discount and quantity threshold' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      bulk_discount_1 = merchant_1.bulk_discounts.create!(percentage_discount: 5, quantity_threshold: 10)
      bulk_discount_2 = merchant_1.bulk_discounts.create!(percentage_discount: 10, quantity_threshold: 15)
      bulk_discount_3 = merchant_1.bulk_discounts.create!(percentage_discount: 20, quantity_threshold: 20)
      bulk_discount_4 = merchant_1.bulk_discounts.create!(percentage_discount: 25, quantity_threshold: 30)
      bulk_discount_5 = merchant_1.bulk_discounts.create!(percentage_discount: 30, quantity_threshold: 50)

      customer_1 = create(:customer)

      items_1 = create_list(:item, 10, unit_price: 50)
      items_2 = create_list(:item, 15, unit_price: 50)

      visit merchant_bulk_discounts_path(merchant_1)
      save_and_open_page
      expect(page).to have_content("Bulk Discounts")
      expect(page).to have_link("#{bulk_discount_1.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_1.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{bulk_discount_1.percentage_discount}% off!")

      expect(page).to have_link("#{bulk_discount_2.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_2.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{bulk_discount_2.percentage_discount}% off!")

      expect(page).to have_link("#{bulk_discount_3.id}")
      expect(page).to have_content("Quantity Threshold: #{bulk_discount_3.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{bulk_discount_3.percentage_discount}% off!")
    end
  end
end