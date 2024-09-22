# frozen_string_literal: true

module Datory
  class Base
    include Info::DSL
    include Context::DSL
    include Getters::DSL
    include Setters::DSL
    include Attributes::DSL
  end
end
