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

      string :lat, to: :latitude
      string :lng, to: :longitude
    end
  end
end
