# frozen_string_literal: true

module Usual
  module Example1
    class UserAddress < Datory::Base
      string :street
      string :suite
      string :city
      string :zipcode, to: :zip_code

      one :geo, include: UserAddressGeo
    end
  end
end
