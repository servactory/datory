# frozen_string_literal: true

module Usual
  module Example1
    class UserLogin < Datory::Base
      uuid :id

      string :username
      string :password

      string :md5 # rubocop:disable Naming/VariableNumber
      string :sha1 # rubocop:disable Naming/VariableNumber

      string :lifetime, as: ActiveSupport::Duration

      string :registered_at, as: DateTime
    end
  end
end
