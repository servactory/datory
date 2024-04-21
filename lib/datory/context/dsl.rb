# frozen_string_literal: true

module Datory
  module Context
    module DSL
      def self.included(base)
        base.extend(Callable)
        base.include(Workspace)
      end
    end
  end
end
