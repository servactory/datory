# frozen_string_literal: true

module Usual
  module Example1
    class Rating < Datory::Base
      float! :value

      # NOTE: To test automatic casting of String to Float.
      attribute :oldValue, from: String, to: :old_value, as: Float

      integer! :quantity

      # NOTE: To test automatic casting of String to Float.
      attribute :oldQuantity, from: String, to: :old_quantity, as: Integer

      string? :linkUrl, to: :link_url
    end
  end
end
