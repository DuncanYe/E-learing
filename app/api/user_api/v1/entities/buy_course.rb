module UserApi::V1::Entities
  class BuyCourse < Grape::Entity
    expose :course_id, documentation: {type: "String", desc: "課程ID"}
    expose :state, documentation: {type: "String", desc: "是否可用"}
    expose :end_at, documentation: {type: "String", desc: "使用到何時"}
    expose :amount, documentation: {type: "Integer", desc: "金額"}
    expose :currency, documentation: {type: "String", desc: "幣別"}
    expose :category, documentation: {type: "String", desc: "種類名稱"} do |obj|
       obj.category.name
    end

  end
end