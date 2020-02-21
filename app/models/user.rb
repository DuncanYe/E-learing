class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
  has_many :user_courses

  enum role: {
    customer: "customer",
    admin: "admin",
  }


  def admin?
    role == "admin"
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
    self.save
  end

end
