module UserApi
  module V1
    class Auth < Grape::API
      helpers UserApi::V1::ApiHelper

      desc "登入", success: Entities::AccessToken
      params do
        requires :email, type: String, desc: "電子郵件"
        requires :password, type: String, desc: "密碼"
      end
      post :login do
        email  = params['email']
        password  = params['password']
        service = Services::VerifyPassword.new(email, password)

        if service.perform
          present :data, current_user , with: Entities::AccessToken
        else
          error! service.error, 422
        end
      end

      # 如果 logout 就把 token 重新製作

    end
  end
end