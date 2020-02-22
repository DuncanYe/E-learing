module UserApi::V1::Services
  class UserCourses
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

    def initialize(user, available, category_id)
      @user = user
      @available = available
      @category_id = category_id
    end

    def _perform
      filter_scope
    end

    def filter_scope
      scope = @user.user_courses

        # binding.pry
      if @available == true
        scope = scope.available
      elsif @available == false
        scope = scope.not_available
      end

      if @category_id
        scope = scope.where(category_id: @category_id)
      end

      @scope = scope
    end
    
  end
end
