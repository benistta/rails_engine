class Item < ApplicationRecord
    belongs_to :merchant
    has_many :invoice_items
    has_many :invoices, through: :invoice_items
    has_many :transactions, through: :invoices

    validates_presence_of :name
    validates_presence_of :description
    validates_presence_of :unit_price
    validates_presence_of :merchant_id

  def self.find_all(name)
    where("name ILIKE ?", "%#{name}%")
  end

  def self.find_one(name)
    where('LOWER(name) LIKE ?', "%#{name.downcase}%").first
  end

  def self.find_min_price(min_price)
    where('unit_price >= ?', min_price).order(:name).first
  end

  def self.find_max_price(max_price)
    where('unit_price <= ?', max_price).order(:name).first
  end
end
