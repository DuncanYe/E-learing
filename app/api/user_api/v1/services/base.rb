module UserApi::V1::Services::Base
  attr_reader :error

  def perform
    result = _perform

    if result
      success
    else
      failure
    end

    result
  end


  def success
  end

  def failure
  end

  def build_error(code, attrs = {}, variables = {})
    err = self.class::ERRORS[code].dup
    err[:details] = err[:details] % attrs
    err[:message] = I18n.t(err[:code], default: err[:details], scope: [:user_api, :v1, :errors], **variables) % attrs
    err
  end

  def set_error(code, attrs = {})
    @error = { error: build_error(code, attrs) }
  end

end
