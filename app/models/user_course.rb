class UserCourse < ApplicationRecord
  belongs_to :user
  belongs_to :category
  belongs_to :course
end
