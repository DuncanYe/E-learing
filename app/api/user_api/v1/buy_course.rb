module UserApi
  module V1
    class BuyCourse < Grape::API

      # desc "購買單一課程", success: Entities::UserCourse
      get :buy_course do
        present :data, UserCourse.first , with: Entities::BuyCourse
      end


    end
  end
end