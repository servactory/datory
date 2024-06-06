# frozen_string_literal: true

module Usual
  module Example2
    class Product < Datory::Base
      uuid! :id

      string! :title
      string! :formatted_title

      money! :price
      money? :discount

      integer! :quantity, min: 1, max: 10

      duration? :installmentDuration, to: :installment_duration

      getter :formatted_title do |attributes:|
        "The New #{attributes.fetch(:title)} (from getter)"
      end

      setter :formatted_title do |attributes:|
        "The New #{attributes.fetch(:title)} (from setter)"
      end
    end
  end
end
