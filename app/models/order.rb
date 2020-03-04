class Order < ApplicationRecord
  belongs_to :user
  belongs_to :user_course
end
