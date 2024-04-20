# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      attribute :id, type: String
      attribute :first_name, as: :first_name, type: String
      attribute :last_name, as: :last_name, type: String
      attribute :email, type: String
      attribute :birth_date, as: :birth_date, type: Date, required: false

      # attribute :company, type: Hash, prepare: ->(value:) { UserCompany.build!(**value) }
    end
  end
end
