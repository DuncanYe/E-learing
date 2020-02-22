module UserApi::V1::Services
  class UserCourses
    include Base
    attr_reader :scope

    class CategoryNotFound < StandardError; end

    ERRORS = {
      :category_not_found => {
        code: 'category_not_found',
        details: 'Category not found'
      },
    }.freeze

    def initialize(user, available, category_id)
      @user = user
      @available = available
      @category_id = category_id
    end

    def _perform
      filter_scope
      true
      rescue CategoryNotFound
      set_error(:category_not_found)
      false
    end

    def filter_scope
      scope = @user.user_courses

      if @available == true
        scope = scope.available
      elsif @available == false
        scope = scope.not_available
      end

      if @category_id
        if !Category.where(id: @category_id).exists?
          raise CategoryNotFound
        else
          scope = scope.where(category_id: @category_id)
        end
      end

      @scope = scope
    end
    
  end
end
