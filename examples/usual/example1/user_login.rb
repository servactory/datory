# frozen_string_literal: true

module Usual
  module Example1
    class UserLogin < Datory::Base
      attribute :uuid, type: String
      attribute :username, type: String
      attribute :password, type: String
      attribute :md5, type: String # rubocop:disable Naming/VariableNumber
      attribute :sha1, type: String # rubocop:disable Naming/VariableNumber
      attribute :registered, type: String
    end
  end
end
