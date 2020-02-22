module UserApi
  module V1
    class Endpoint < Grape::API
      format :json

      desc "測試"
      get :ping do
        { data: Time.current.iso8601 }
        # 可改成時間
      end

      mount Auth
      mount BuyCourse
      mount UserCourses


      route :any, '*path' do
        error!({ message: 'Not Found' }, 404)
      end


    end
  end
end