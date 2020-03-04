require 'rails_helper'

RSpec.describe UserApi::V1::BuyCourse, type: :request do
  let!(:category) { Category.create(name: '教育') }
  let!(:user) { @current_user = User.create(email: '123@123', password: '111111', authentication_token: '123') }
  let!(:course) { Course.create(name: "一起學", state: 'available',
                                category_id: category.id, user_id: user.id,
                                price: 100, currency: 'tw',
                                available_day: Time.now+10.day) }
  context 'success' do
    before do
       Timecop.freeze Time.current
    end
    it 'return user course info' do
      post "http://localhost:3000/user_api/v1/buy_course",
          {params: {token: user.authentication_token, course_id: course.id}}
      result = JSON.parse(response.body)
      expect(response).to be_successful
      expect(result["data"]).to eq("amount"=>course.price, "category"=> course.category.name, "course_id"=> course.id,
                                   "currency"=> course.currency, "end_at"=>course.available_day.strftime('%Y-%m-%d %H:%M'),
                                   "state"=>"available",
                                   "order"=>{ "id"=> user.orders.first.id, "amount" => user.orders.first.amount, "user_course_name" => course.name})
    end
  end

  context 'Error Case' do
    # messing token
    it 'Invalid Token' do
      post "http://localhost:3000/user_api/v1/buy_course",
          {params: {token: '2', course_id: 1}}
      result = JSON.parse(response.body)
      expect(response).to_not be_successful
      expect(result["error"]).to eq("code"=>"invalid_token", "details"=>"Invalid token", "message"=>"Invalid token")
    end

    it 'Course Not Found' do
      post "http://localhost:3000/user_api/v1/buy_course",
          {params: {token: user.authentication_token, course_id: 100}}
      result = JSON.parse(response.body)
      expect(response).to_not be_successful
      expect(result["error"]).to eq("code"=>"course_not_found", "details"=>"Course Not Found", "message"=>"Course Not Found")
    end

    it 'Availble Course Exist' do
      user.user_courses.create(end_at: course.available_day, state: "available",
                               amount: course.price, currency: course.currency,
                               category_id: course.category_id,
                               course_id: course.id)
      post "http://localhost:3000/user_api/v1/buy_course",
          {params: {token: user.authentication_token, course_id: course.id}}
      result = JSON.parse(response.body)
      expect(response).to_not be_successful
      expect(result["error"]).to eq("code"=>"availble_course_exist", "details"=>"Availble Course Exist", "message"=>"Availble Course Exist")
    end

    it 'Course Is Discontinued' do
      course.state = 'discontinued'
      course.save
      post "http://localhost:3000/user_api/v1/buy_course",
          {params: {token: user.authentication_token, course_id: course.id}}
      result = JSON.parse(response.body)
      expect(response).to_not be_successful
      expect(result["error"]).to eq("code"=>"course_is_discontinued", "details"=>"Course Is Discontinued", "message"=>"Course Is Discontinued")
    end

  end
end

