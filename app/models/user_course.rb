class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :course

  scope :available, -> { where(state: ["available"])}
  scope :not_available, -> { where(state: ["discontinued"])}
end
