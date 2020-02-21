class Course < ApplicationRecord
  validates :name, :available_day, :price, :currency, :state,  presence: true
  validates_numericality_of :price, :greater_than_or_equal_to => 0

  belongs_to :category

  enum currency: {
    tw: "tw",
    usa: "usa",
  }


  enum state: {
    available: "available",
    discontinued: "discontinued",
  }
end
