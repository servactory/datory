# frozen_string_literal: true

module Usual
  module Example1
    class Genre < Datory::Base
      string! :name
      string! :code
    end
  end
end
