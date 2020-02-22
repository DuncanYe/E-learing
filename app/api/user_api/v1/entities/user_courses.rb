module UserApi::V1::Entities
    class UserCourses < Grape::Entity
      expose :id, documentation: {type: "String", desc: "ID"}
      expose :course, documentation: {type: "String", desc: "課程名稱"} do |obj|
        obj.course.name
      end
      expose :course_id, documentation: {type: "String", desc: "課程名稱"} do |obj|
        obj.course.id
      end
      expose :category, documentation: {type: "String", desc: "種類"} do |obj|
        obj.category.name
      end
      expose :end_at, documentation: {type: "String", desc: "有效日期"} do |obj|
        obj.end_at.iso8601
      end
      expose :state, documentation: {type: "String", desc: "狀態"}
      expose :amount, documentation: {type: "String", desc: "金額"}
      expose :currency, documentation: {type: "String", desc: "幣別"}
    end
end
