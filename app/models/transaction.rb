class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates :amount,:date,presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :category, presence: true
end
