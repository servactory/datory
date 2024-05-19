# frozen_string_literal: true

module Usual
  module Example1
    class Ratings < Datory::Base
      one! :imdb, include: Rating
    end
  end
end
