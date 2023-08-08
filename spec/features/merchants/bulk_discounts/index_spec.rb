require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Index Page' do
  describe "US_1 (pt 2)" do 
    it 'displays all bulk discounts with percentage of discount and quantity threshold' do
      bulk_discount_test_data

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
      bulk_discount_test_data

      visit merchant_bulk_discounts_path(@merchant_1)

      within "#create_discount" do
        expect(page).to have_link("Create New Discount")
      end

      click_link "Create New Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
      
      within "#new_discount_form" do
        expect(page).to have_field("Percentage discount")
        expect(page).to have_field("Quantity threshold")
        expect(page).to have_button("Create New Discount")
      end

      fill_in "Percentage discount", with: 50
      fill_in "Quantity threshold", with: 100
      click_button "Create New Discount"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))
      
      within '#all_merchant_discounts' do
        expect(page).to have_content("50.0% off!")
        expect(page).to have_content("Quantity Threshold: 100")
      end
    end

    it "can't create a discount without filling in all fields" do
      bulk_discount_test_data

      visit merchant_bulk_discounts_path(@merchant_1)
      click_link "Create New Discount"
      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
      
      fill_in "Percentage discount", with: ''
      fill_in "Quantity threshold", with: ''
      click_button "Create New Discount"

      expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant_1))
      expect(page).to have_content("Please fill in all fields")
      
      expect(page).to have_field("Percentage discount")
      expect(page).to have_field("Quantity threshold")
    end
  end

  describe "US_3 Delete Discount" do 
    it "displays a link next to each discount to delete a discount" do
      bulk_discount_test_data

      visit merchant_bulk_discounts_path(@merchant_1)

      within "#all_merchant_discounts" do
        expect(page).to have_link("Delete Discount #{@bulk_discount_1.id}")
      end

      click_link "Delete Discount #{@bulk_discount_1.id}"

      expect(current_path).to eq(merchant_bulk_discounts_path(@merchant_1))

      within "#all_merchant_discounts" do
        expect(page).to_not have_content(@bulk_discount_1.id)
        expect(page).to have_content(@bulk_discount_2.id)
      end
      
      expect(page).to have_content("Discount ##{@bulk_discount_1.id} Successfully Deleted")
    end
  end

  describe "US_9 Next 3 Holidays API" do 
    it "displays the next 3 holidays" do
      bulk_discount_test_data

      visit merchant_bulk_discounts_path(@merchant_1)
      
      expect(page).to have_content("Upcoming Holidays")

      upcoming_holidays = SwaggerService.new.next_three_holidays

      expect(page).to have_content("#{upcoming_holidays[0].name} - #{upcoming_holidays[0].date}")
      expect(page).to have_content("#{upcoming_holidays[1].name} - #{upcoming_holidays[1].date}")
      expect(page).to have_content("#{upcoming_holidays[2].name} - #{upcoming_holidays[2].date}")

      expect(upcoming_holidays[0].date).to appear_before(upcoming_holidays[1].date)
      expect(upcoming_holidays[1].date).to appear_before(upcoming_holidays[2].date)
    end
  end
end