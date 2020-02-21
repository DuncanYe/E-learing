module UserApi
  module V1
    class BuyCourse < Grape::API
      extend UserApi::V1::Helpers::DocHelper

      # desc "購買單一課程", success: Entities::UserCourse
      get :buy_course do
        present :data, UserCourse.first , with: Entities::UserCourse
      end


    end
  end
end