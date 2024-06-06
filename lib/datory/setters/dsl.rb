# frozen_string_literal: true

module Datory
  module Setters
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
        base.include(Workspace)
      end

      module ClassMethods
        def inherited(child)
          super

          child.send(:collection_of_setters).merge(collection_of_setters)
        end

        private

        def setter(name)
          collection_of_setters << Setter.new(name, ->(attributes:) { yield(attributes: attributes) })
        end

        def collection_of_setters
          @collection_of_setters ||= Collection.new
        end
      end
    end
  end
end
