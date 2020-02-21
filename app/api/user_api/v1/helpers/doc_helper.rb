# frozen_string_literal: true
module UserApi::V1::Helpers::DocHelper
  def doc_errors(klass)
    desc = klass::ERRORS.values.map { |x| "code: #{x[:code]} (解說: #{x[:details]})" }.join("\n")

    [{code: 422,
      message: desc,
      model: UserApi::V1::Entities::Error}]
  end
end
