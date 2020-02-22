class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :course

  scope :available, -> { where(state: ["available"])}
end
