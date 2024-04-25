# frozen_string_literal: true

module Usual
  module Example1
    class UserAddressGeo < Datory::Base
      string :lat, to: :latitude
      string :lng, to: :longitude
    end
  end
end
