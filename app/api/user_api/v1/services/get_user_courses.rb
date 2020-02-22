module UserApi::V1::Services
  class GetUserCourses
    include Base
    attr_reader :scope

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

    def initialize(user)
    end

    def _perform
      @scope = UserCourse.all
    #   check_user_password

    #   true
    # rescue UserNotFound
    #   set_error(:user_not_found)
    #   false
    # rescue PasswordError
    #   set_error(:password_error)
    #   false
    end



    
  end
end
