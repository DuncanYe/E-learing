module UserApi::V1::Services
  class VerifyPassword
    include Base
    attr_reader :access_token

    class UserNotFound < StandardError; end
    class PasswordError < StandardError; end

    ERRORS = {
      :user_not_found => {
        code: 'user_not_found',
        details: 'User not found'
      },
      :password_error => {
        code: 'password_error',
        details: 'Password error'
      },
    }.freeze

    def initialize(email, password)
      @email     = email
      @password  = password
      @user      = User.find_by(email: @email)
    end

    def _perform
      check_user_password

      @user.generate_authentication_token
      true
    rescue UserNotFound
      set_error(:user_not_found)
      false
    rescue PasswordError
      set_error(:password_error)
      false
    end

    def check_user_password
      if @user.nil?
        raise UserNotFound
      elsif !@user.valid_password?(@password)
        raise PasswordError
      end
    end

    
  end
end
