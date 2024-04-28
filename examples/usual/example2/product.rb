# frozen_string_literal: true

module Usual
  module Example2
    class Product < Datory::Base
      uuid :id

      string :title

      money :price
    end
  end
end
