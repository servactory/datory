# frozen_string_literal: true

module Usual
  module Example2
    class Product < Datory::Base
      uuid! :id

      string! :title

      money! :price
      money? :discount

      integer! :quantity, min: 1, max: 10
    end
  end
end
