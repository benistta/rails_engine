class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.find_merchant(name)
    where("name ILIKE ?", "%#{name}%").first
  end

  def self.find_all_merchants(name)
   where("name ilike ?", "%#{name.strip}%")
 end
end
