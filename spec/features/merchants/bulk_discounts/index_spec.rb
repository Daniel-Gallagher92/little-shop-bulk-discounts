require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index Page' do
  describe "US_1 (pt 2)" do 
    it 'displays all bulk discounts with percentage of discount and quantity threshold' do
      bulk_discount_index

      expect(page).to have_content("Bulk Discounts")
      expect(page).to have_link("#{@bulk_discount_1.id}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_1.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount_1.percentage_discount}% off!")

      expect(page).to have_link("#{@bulk_discount_2.id}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_2.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount_2.percentage_discount}% off!")

      expect(page).to have_link("#{@bulk_discount_3.id}")
      expect(page).to have_content("Quantity Threshold: #{@bulk_discount_3.quantity_threshold}")
      expect(page).to have_content("Percentage Discount: #{@bulk_discount_3.percentage_discount}% off!")
    end
  end

  describe "US_2 Create Discount" do
    it "has a link to create a new discount" do
      bulk_discount_index

      visit merchant_bulk_discounts_path(@merchant_1)

      within "#create_discount" do
        expect(page).to have_link("Create New Discount")
      end

      click_link "Create New Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))

      save_and_open_page
    end
  end
end