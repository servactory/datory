# frozen_string_literal: true

module Usual
  module Example1
    class UserAddressGeo < Datory::Base
      attribute :latitude, type: String
      attribute :longitude, type: String
    end
  end
end
