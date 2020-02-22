module UserApi
  module V1
    class UserCourses < Grape::API
      helpers UserApi::V1::ApiHelper

      resources :user_courses do
        desc "拿取加油請款訂單(時間倒序排)", success: Entities::UserCourses
        params do
          requires :token, type: String, desc: "憑證"
          optional :available, type: Boolean, values: [true, false],  desc: "有效課程"
          optional :category_id, type: Integer,  desc: "類別ID"
        end
        get '/' do
          available = params['available']
          category_id = params['category_id']

          service = Services::UserCourses.new(current_user, available, category_id)
          if service.perform
            present service.scope, with: Entities::UserCourses
          else
            error! service.error, 422
          end

        end
      end

    end
  end
end