module UserApi
  module V1
    class Endpoint < Grape::API
      format :json

      desc "測試"
      get :ping do
        { data: "pong" }
      end

      mount Auth
      mount BuyCourse


      route :any, '*path' do
        error!({ message: 'Not Found' }, 404)
      end


    end
  end
end