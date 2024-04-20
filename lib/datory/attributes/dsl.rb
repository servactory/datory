# frozen_string_literal: true

module Datory
  module Attributes
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
        base.include(Workspace)
      end

      module ClassMethods
        def inherited(child)
          super

          child.send(:collection_of_attributes).merge(collection_of_attributes)
        end

        private

        def attribute(name, **options)
          collection_of_attributes << Attribute.new(name, **options)
        end

        def collection_of_attributes
          @collection_of_attributes ||= Collection.new
        end
      end
    end
  end
end
