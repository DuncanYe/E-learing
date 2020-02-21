class Admin::CoursesController < Admin::BaseController
  before_action :set_course

  def index
    @courses = Course.all.includes(:category)
  end

  def new
  end

  def create
   @course = Course.new(course_params)
    if @course.save
      redirect_to admin_courses_path, notice: "新增商品完成"
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
  end


  def destroy
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

end
