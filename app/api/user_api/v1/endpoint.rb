module UserApi
  module V1
    class Endpoint < Grape::API
      format :json

      get :ping do
        { data: "pong" }
      end

      mount BuyCourse


    end
  end
end