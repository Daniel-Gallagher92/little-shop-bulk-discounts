class BulkDiscountsController < ApplicationController 

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @us_holidays = SwaggerService.new.next_three_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @bulk_discount = BulkDiscount.new(bulk_discount_params)
    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
      flash[:notice] = "Please fill in all fields"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    bulk_discount = BulkDiscount.find_by(id: params[:id], merchant_id: params[:merchant_id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(merchant)
    flash[:alert] = "Discount ##{bulk_discount.id} Successfully Deleted"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
    if @bulk_discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
      flash[:notice] = "Bulk discount successfully updated"
    else 
      redirect_to edit_merchant_bulk_discount_path(@merchant, @bulk_discount)
      flash[:notice] = "Please fill in all fields"
    end
  end

  private 

  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold, :merchant_id)
  end

end