class Category < ActiveRecord::Base
  belongs_to :user
  has_many :transactions

  validates :source,:type,presence: true
  validates :source, uniqueness: { scope: :user_id,case_sensitive: false}
end
