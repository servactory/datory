# frozen_string_literal: true

module Usual
  module Example1
    class UserLogin < Datory::Base
      class ARModel
        attr_accessor :uuid,
                      :username,
                      :password,
                      :md5, # rubocop:disable Naming/VariableNumber
                      :sha1, # rubocop:disable Naming/VariableNumber
                      :lifetime,
                      :registered_at

        def initialize(uuid:, username:, password:, md5:, sha1:, lifetime:, registered_at:)
          @uuid = uuid
          @username = username
          @password = password
          @md5 = md5 # rubocop:disable Naming/VariableNumber
          @sha1 = sha1 # rubocop:disable Naming/VariableNumber
          @lifetime = lifetime
          @registered_at = registered_at
        end
      end

      ##########################################################################

      # EXAMPLE:
      #    JSON: lifetime » from String » to lifetime » as Duration

      uuid :uuid
      string :username
      string :password
      string :md5 # rubocop:disable Naming/VariableNumber
      string :sha1 # rubocop:disable Naming/VariableNumber
      string :lifetime, as: ActiveSupport::Duration
      string :registered, to: :registered_at, as: DateTime
    end
  end
end
