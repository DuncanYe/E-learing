module UserApi::V1::Entities
  class Error < Grape::Entity
    expose :code,    documentation: {type: "String", desc: "錯誤代碼"}
    expose :details, documentation: {type: "String", desc: "錯誤訊息詳細說明"}
    expose :message, documentation: {type: "String", desc: "給使用者看的說明"}
  end
end
