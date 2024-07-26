# frozen_string_literal: true

module Datory
  module Getters
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
        base.include(Workspace)
      end

      module ClassMethods
        def inherited(child)
          super

          child.send(:collection_of_getters).merge(collection_of_getters)
        end

        private

        def getter(name)
          collection_of_getters << Getter.new(name, ->(attributes:) { yield(attributes: attributes) })
        end

        def collection_of_getters
          @collection_of_getters ||= Collection.new
        end
      end
    end
  end
end
