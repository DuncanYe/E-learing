# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



Category.destroy_all

category_list = [
  {name: "程式語言"},
  {name: "音樂"},
  {name: "教育"},
  {name: "人文"}
]

category_list.each do |category|
  Category.create( name: category[:name])
  puts "#{category[:name]} has created!"
end

#Default admin
User.create(email: "root@example.com", password: "111111", role: "admin")
puts "Default admin create!"


price = [100, 200, 300]
30.times do |i|
  p = Course.create(
    name: FFaker::Product.product_name,
    price: price.sample,
    currency: Course.currencies.keys.sample,
    category_id: Category.all.sample.id,
    state: Course.states.keys.sample,
    available_day: Time.new+10.day,
  )
  puts p.name
end

