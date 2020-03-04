class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :course
  has_one :order
  

  scope :available, -> { where(state: ["available"])}
  scope :not_available, -> { where(state: ["discontinued"])}
end
