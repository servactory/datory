# frozen_string_literal: true

module Usual
  module Example1
    class UserLogin < Datory::Base
      class ARModel
        attr_accessor :uuid,
                      :username,
                      :password,
                      :md5,
                      :sha1,
                      :registered

        def initialize(uuid:, username:, password:, md5:, sha1:, registered:)
          @uuid = uuid
          @username = username
          @password = password
          @md5 = md5
          @sha1 = sha1
          @registered = registered
        end
      end

      string :uuid
      string :username
      string :password
      string :md5 # rubocop:disable Naming/VariableNumber
      string :sha1 # rubocop:disable Naming/VariableNumber
      string :registered
    end
  end
end
