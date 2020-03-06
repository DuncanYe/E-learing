class Admin::CoursesController < Admin::BaseController
  before_action :set_course
  load_and_authorize_resource

  def index
    @courses = Course.all.includes(:category)
  end

  def new
  end

  def create
   @course = Course.new(course_params)
    if @course.save
      available_day_check
      redirect_to admin_courses_path, notice: "新增課程完成"
    else
      flash.now[:error] = @course.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @course.update(course_params)
      available_day_check
      redirect_to admin_courses_path, notice: "更新課程完成"
    else
      flash.now[:error] = @course.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def set_course
    @course = if params[:id]
                Course.find(params[:id])
              else
                Course.new
              end
  end

  def course_params
    params.require(:course).permit(:name, :price, :currency, :state, :available_day,
                                    :desc, :category_id, :url)
  end

  def available_day_check
    @course.available_day = @course.available_day.end_of_day
    @course.save
  end

end
