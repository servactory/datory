# frozen_string_literal: true

module Usual
  module Example1
    class Rating < Datory::Base
      float :value
      integer :quantity
    end
  end
end
