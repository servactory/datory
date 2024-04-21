# frozen_string_literal: true

module Usual
  module Example1
    class UserAddress < Datory::Base
      class ARModel
        attr_accessor :street,
                      :suite,
                      :city,
                      :zip_code,
                      :geo

        def initialize(street:, suite:, city:, zip_code:, geo:)
          @street = street
          @suite = suite
          @city = city
          @zip_code = zip_code
          @geo = geo
        end
      end

      string :street
      string :suite
      string :city
      string :zipcode, as: :zip_code

      one :geo, to: UserAddressGeo
    end
  end
end
