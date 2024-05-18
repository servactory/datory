# frozen_string_literal: true

module Usual
  module Example1
    class Rating < Datory::Base
      float! :value
      integer! :quantity

      string? :linkUrl, to: :link_url
    end
  end
end
