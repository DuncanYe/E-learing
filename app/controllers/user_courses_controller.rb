class UserCoursesController < ApplicationController

  def create
    if params["course"]
      course = Course.find(params["course"])
      user_course = current_user.user_courses
                    .build(end_at: course.available_day, state: "vailable",
                           amount: course.price, category_id: course.category_id,
                           course_id: course.id)
      if user_course.save
        redirect_to root_path, notice: '成功購買課程'
      else
        redirect_to root_path, notice: 'error'
      end
    else
      redirect_to root_path, notice: 'error'
    end
  end



end
