require 'rails_helper'

RSpec.describe UserApi::V1::UserCourses, type: :request do
  let!(:category_1) { Category.create(name: '教育') }
  let!(:category_2) { Category.create(name: '程式語言') }
  let!(:user) { @current_user = User.create(email: '123@123', password: '111111', authentication_token: '123') }
  let!(:course_1) { Course.create(name: "一起學", state: 'available',
                                category_id: category_1.id, user_id: user.id,
                                price: 100, currency: 'tw',
                                available_day: Time.now+10.day) }
  let!(:course_2) { Course.create(name: "宇宙課", state: 'available',
                                category_id: category_2.id, user_id: user.id,
                                price: 100, currency: 'tw',
                                available_day: Time.now+10.day) }
  let!(:user_course_1){ user.user_courses.create(end_at: course_1.available_day, state: "available",
                                              amount: course_1.price, currency: course_1.currency,
                                              category_id: course_1.category_id,
                                              course_id: course_1.id)
  }
  let!(:order_1){ Order.create(user: user,
                               user_course: user_course_1,
                               amount: user_course_1.amount)}
  let!(:user_course_2){ user.user_courses.create(end_at: course_2.available_day, state: "discontinued",
                                              amount: course_2.price, currency: course_2.currency,
                                              category_id: course_2.category_id,
                                              course_id: course_2.id)
  }
  let!(:order_2){ Order.create(user: user,
                               user_course: user_course_2,
                               amount: user_course_2.amount)}
  context 'success' do
    before do
       Timecop.freeze Time.current
    end
    it 'return all user courses' do
      get "http://localhost:3000/user_api/v1/user_courses",
          {params: {token: user.authentication_token}}
      result = JSON.parse(response.body)
      expect(response).to be_successful
      data = result['data']
      expect(data.size).to eq(2)

    end

    it 'filter by category' do
      get "http://localhost:3000/user_api/v1/user_courses",
          {params: {token: user.authentication_token, category_id: category_1.id}}
      result = JSON.parse(response.body)
      expect(response).to be_successful
      data = result['data'][0]
      expect(data['amount']).to eq user_course_1.amount
      expect(data['category']).to eq user_course_1.category.name
      expect(data['course']).to eq user_course_1.course.name
      expect(data['currency']).to eq user_course_1.currency
      expect(data['state']).to eq user_course_1.state
    end

    it 'filter by available user_courses' do
      get "http://localhost:3000/user_api/v1/user_courses",
          {params: {token: user.authentication_token, available: true}}
      result = JSON.parse(response.body)
      expect(response).to be_successful
      data = result['data'][0]
      expect(data['amount']).to eq user_course_1.amount
      expect(data['category']).to eq user_course_1.category.name
      expect(data['course']).to eq user_course_1.course.name
      expect(data['currency']).to eq user_course_1.currency
      expect(data['state']).to eq user_course_1.state
    end

     it 'filter by discontinued user_courses' do
      get "http://localhost:3000/user_api/v1/user_courses",
          {params: {token: user.authentication_token, available: false}}
      result = JSON.parse(response.body)
      expect(response).to be_successful
      data = result['data'][0]
      expect(data['amount']).to eq user_course_2.amount
      expect(data['category']).to eq user_course_2.category.name
      expect(data['course']).to eq user_course_2.course.name
      expect(data['currency']).to eq user_course_2.currency
      expect(data['state']).to eq user_course_2.state
    end

  end

  context 'Error Case' do
    it 'Category Not Found' do
      get "http://localhost:3000/user_api/v1/user_courses",
          {params: {token: user.authentication_token, category_id: 1001}}
      result = JSON.parse(response.body)
      expect(response).to_not be_successful
      expect(result["error"]).to eq("code"=>"category_not_found", "details"=>"Category not found", "message"=>"Category not found")
    end
  end
end

