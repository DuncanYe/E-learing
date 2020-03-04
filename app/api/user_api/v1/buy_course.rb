module UserApi
  module V1
    class BuyCourse < Grape::API
      helpers UserApi::V1::ApiHelper

      desc "購買單一課程", success: Entities::UserCourse
      params do
        requires :token, type: String, desc: "憑證"
        requires :course_id, type: Integer, desc: "課程ID"
      end
      post :buy_course do
        course_id = params['course_id']

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