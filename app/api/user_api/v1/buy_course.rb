module UserApi
  module V1
    class BuyCourse < Grape::API
      helpers UserApi::V1::ApiHelper

      desc "購買單一課程", success: Entities::UserCourse
      params do
        requires :token, type: String, desc: "憑證"
        requires :course_id, type: Integer, desc: "課程ID"
      end
      get :buy_course do
        # 要改成，錯誤的 Token，請重新登入拿取最新的 Token
        course_id = params['course_id']

        # 拿到 user 拿到 course_id 建立 course
        # 上架的才能買
        # 還可使用的課，不可重複購買
        service = Services::BuyCourse.new(current_user, course_id)
        if service.perform
          present :data, service.user_course , with: Entities::BuyCourse
        else
          error! service.error, 422
        end
      end

    end
  end
end