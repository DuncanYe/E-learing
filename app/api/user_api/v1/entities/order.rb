module UserApi::V1::Entities
    class Order < Grape::Entity
      expose :id, documentation: {type: "String", desc: "編號"}
      expose :amount, documentation: {type: "String", desc: "金額"}
      expose :user_course_name, documentation: {type: "String", desc: "課程名稱"} do |obj|
        obj.user_course.course.name
      end
    end
end
