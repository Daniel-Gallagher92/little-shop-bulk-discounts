class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items, dependent: :destroy
  has_many :merchants, through: :items, dependent: :destroy
  has_many :bulk_discounts, through: :merchants, dependent: :destroy

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_invoice_discount 
    invoice_items.joins(:bulk_discounts)
    .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
    .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (bulk_discounts.percentage_discount / 100)) AS total_invoice_discount')
    .group('invoice_items.id')
    .sum(&:total_invoice_discount)
  end

  def total_revenue_with_discount
    (total_revenue - total_invoice_discount)
  end
end
