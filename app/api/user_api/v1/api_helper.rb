module UserApi::V1::ApiHelper

  def current_user
    @_current_user ||= User.find_by email: params["email"]
  end

end
