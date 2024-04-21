# frozen_string_literal: true

module Usual
  module Example1
    class UserAddressGeo < Datory::Base
      class ARModel
        attr_accessor :latitude,
                      :longitude

        def initialize(latitude:, longitude:)
          @latitude = latitude
          @longitude = longitude
        end
      end

      string :lat, as: :latitude
      string :lng, as: :longitude
    end
  end
end
