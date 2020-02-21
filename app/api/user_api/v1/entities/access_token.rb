module UserApi::V1::Entities
    class AccessToken < Grape::Entity
      expose :authentication_token, documentation: {type: "String", desc: "憑證"}
    end
end
