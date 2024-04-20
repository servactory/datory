# frozen_string_literal: true

module Usual
  module Example1
    class UserAddress < Datory::Base
      attribute :street, type: String
      attribute :suite, type: String
      attribute :city, type: String
      attribute :zip_code, type: String

      attribute :geo, type: Hash, prepare: ->(value:) { UserAddressGeo.build!(**value) }
    end
  end
end
