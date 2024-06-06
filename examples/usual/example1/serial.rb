# frozen_string_literal: true

module Usual
  module Example1
    class Serial < Datory::Base
      uuid! :id

      string! :status
      string! :title

      one! :poster, include: Image

      one! :ratings, include: Ratings

      many! :countries, include: Country
      many! :genres, include: Genre
      many! :seasons, include: Season

      date! :premieredOn, to: :premiered_on
    end
  end
end
