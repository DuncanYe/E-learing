class CoursesController < ApplicationController
  def index
    @courses = Course.avalible_courses.includes(:category)
  end

  def show
  end
end
