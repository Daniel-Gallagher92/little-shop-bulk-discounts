require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Edit Page' do
  describe 'US_5 (pt. 2)' do
    it 'has a form to edit the bulk discount' do
      bulk_discount_test_data
      visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)
      
      expect(page).to have_field("Quantity threshold", with: 10)
      expect(page).to have_field("Percentage discount", with: 5.0)
      expect(page).to have_button("Update Discount")
      
      fill_in "Percentage discount", with: 20
      fill_in "Quantity threshold", with: 15
      click_button "Update Discount"
      
      expect(current_path).to eq(merchant_bulk_discount_path(@merchant_1, @bulk_discount_1))
      expect(page).to have_content("Bulk discount successfully updated")
      
      within "#discount-show" do
        expect(page).to have_content("Percentage Discount: 20.0% off!")
        expect(page).to have_content("Quantity Threshold: 15")
      end
    end

    it 'displays a flash message if the form is not filled in completely' do
      bulk_discount_test_data
      visit edit_merchant_bulk_discount_path(@merchant_1, @bulk_discount_1)

      fill_in "Percentage discount", with: ''
      fill_in "Quantity threshold", with: ''
      click_button "Update Discount"

      expect(page).to have_content("Please fill in all fields")
    end
  end
end