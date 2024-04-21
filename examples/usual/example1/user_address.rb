# frozen_string_literal: true

module Usual
  module Example1
    class UserAddress < Datory::Base
      string :street
      string :suite
      string :city
      string :zipcode, as: :zip_code

      one :geo, to: UserAddressGeo
    end
  end
end
