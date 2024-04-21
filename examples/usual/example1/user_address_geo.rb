# frozen_string_literal: true

module Usual
  module Example1
    class UserAddressGeo < Datory::Base
      string :lat, as: :latitude
      string :lng, as: :longitude
    end
  end
end
