module UserApi::V1::Entities
  class UserCourse < Grape::Entity
    expose :state, documentation: {type: "String", desc: "課程名稱"}
    
  end
end