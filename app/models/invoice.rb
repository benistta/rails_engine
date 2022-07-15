class Invoice < ApplicationRecord
  validates :status, presence: true

  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :transactions
  has_many :items, through: :invoice_items

  def self.delete(invoices, item)
    invoices.each do |inv|
      if item.count == 1
        inv.destroy
      end
    end
  end
end
