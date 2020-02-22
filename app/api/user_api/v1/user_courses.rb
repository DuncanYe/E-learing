module UserApi
  module V1
    class UserCourses < Grape::API
      helpers UserApi::V1::ApiHelper

      resources :user_courses do
        desc "拿取加油請款訂單(時間倒序排)", success: Entities::UserCourses
        params do
          requires :token, type: String, desc: "憑證"
          optional :available_course, type: String,  desc: "有效課程"
          optional :category_id, type: String,  desc: "類別ID"
        end
        get '/' do

          service = Services::GetUserCourses.new(current_user)
          if service.perform
            present service.scope, with: Entities::UserCourses
          else
            error! service.error, 422
          end

        end
      end

      # desc "購買單一課程", success: Entities::UserCourse
      # params do
      #   requires :token, type: String, desc: "憑證"
      #   requires :course_id, type: Integer, desc: "課程ID"
      # end
      # post :buy_course do
      #   # 要改成，錯誤的 Token，請重新登入拿取最新的 Token
      #   course_id = params['course_id']

      #   # 拿到 user 拿到 course_id 建立 course
      #   # 上架的才能買
      #   # 還可使用的課，不可重複購買
      #   service = Services::BuyCourse.new(current_user, course_id)
      #   if service.perform
      #     present :data, service.user_course , with: Entities::BuyCourse
      #   else
      #     error! service.error, 422
      #   end
      # end

    end
  end
end