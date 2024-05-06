# frozen_string_literal: true

module Usual
  module Example1
    class Country < Datory::Base
      string :name
      string :iso2 # rubocop:disable Naming/VariableNumber
    end
  end
end
