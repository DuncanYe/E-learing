module UserApi::V1::Services
  class BuyCourse
    include Base

    class InvalidToken  < StandardError; end
    class CourseNotFound  < StandardError; end
    class FaildToBuildCourse  < StandardError; end
    class AvailbleCourseExist  < StandardError; end
    class CourseIsDiscontinued  < StandardError; end

    ERRORS = {
      :invalid_token => {
        code: 'invalid_token',
        details: 'Invalid token'
      },
      :course_not_found => {
        code: 'course_not_found',
        details: 'Course Not Found'
      },
      :faild_to_build_course => {
        code: 'faild_to_build_course',
        details: 'Faild to build course'
      },
      :availble_course_exist => {
        code: 'availble_course_exist',
        details: 'Availble Course Exist'
      },
      :course_is_discontinued => {
        code: 'course_is_discontinued',
        details: 'Course Is Discontinued'
      },
    }.freeze

    attr_reader :user_course

    def initialize(user, course_id)
      @user = user
      @course_id     = course_id
    end

    def _perform

      find_and_buy_course
      true
      rescue InvalidToken
      set_error(:invalid_token)
      false
      rescue CourseNotFound
      set_error(:course_not_found)
      false
      rescue FaildToBuildCourse
      set_error(:faild_to_build_course)
      false
      rescue AvailbleCourseExist
      set_error(:availble_course_exist)
      false
      rescue CourseIsDiscontinued
      set_error(:course_is_discontinued)
      false
    end

    def find_and_buy_course
      if @user.nil?
        raise InvalidToken
      end

      @user_course = build_user_course

      ActiveRecord::Base.transaction do
        if @user_course.save
          # send email to user
          # 金流付款
          @user_course
        else
          # 噴 Slack 通知無法建立
          raise FaildToBuildCourse
        end
      end

    end

    def build_user_course
      @course = Course.find_by(id: @course_id)
      if @course.nil?
        raise CourseNotFound
      end

      if @course.state == "discontinued"
        raise CourseIsDiscontinued
      end

      if @user.user_courses.where(course_id: @course.id, state: 'available').exists?
        raise AvailbleCourseExist
      end
      @user.user_courses.build(end_at: @course.available_day, state: "available",
                               amount: @course.price, currency: @course.currency,
                               category_id: @course.category_id,
                               course_id: @course.id)
      
    end
    
  end
end
