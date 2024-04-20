# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      attribute :id, type: Integer
      attribute :first_name, as: :firstname, type: String
      attribute :last_name, as: :lastname, type: String
      attribute :email, type: String
      attribute :birth_date, as: :birthDate, type: Date, required: false

      # attribute :company, type: Hash, prepare: ->(value:) { UserCompany.build!(value) }
    end
  end
end
