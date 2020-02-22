require 'rails_helper'

RSpec.describe UserApi::V1::Endpoint, type: :request do
  context '確認連線正常' do
    before do
       Timecop.freeze Time.current
    end
    it '回傳當下時間' do
      get "http://localhost:3000/user_api/v1/ping"
      result = JSON.parse(response.body)
      expect(response.status).to be 200
      expect(result['data']).to eq(Time.current.iso8601)
    end
  end
end

