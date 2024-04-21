# frozen_string_literal: true

module Usual
  module Example1
    class UserAddressGeo < Datory::Base
      attribute :lat, as: :latitude, type: String
      attribute :lng, as: :longitude, type: String
    end
  end
end
