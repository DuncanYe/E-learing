module UserApi::V1::ApiHelper

  def current_user
    if params['token']
      @_current_user ||= User.find_by authentication_token: params["token"]
    else
      @_current_user ||= User.find_by email: params["email"]
    end
  end

  # def authenticate!
  #   error!('401 Unauthorized', 401) unless current_user
  # end

end
