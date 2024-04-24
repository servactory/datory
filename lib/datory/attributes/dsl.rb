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

        ########################################################################

        def one(name, include:, to: nil)
          attribute(name, to: to.presence || name, from: Hash, include: include)
        end

        def many(name, include:, to: nil)
          attribute(name, to: to.presence || name, from: Array, consists_of: Hash, include: include)
        end

        ########################################################################

        def uuid(name, **options)
          options = options.merge(format: :uuid)
          string(name, **options)
        end

        ########################################################################

        def symbol(name, **options)
          options = options.merge(from: Symbol)
          attribute(name, **options)
        end

        def string(name, **options)
          options = options.merge(from: String)
          attribute(name, **options)
        end

        def integer(name, **options)
          options = options.merge(from: Integer)
          attribute(name, **options)
        end

        def float(name, **options)
          options = options.merge(from: Float)
          attribute(name, **options)
        end

        def date(name, **options)
          options = options.merge(from: Date)
          attribute(name, **options)
        end

        def time(name, **options)
          options = options.merge(from: Time)
          attribute(name, **options)
        end

        def datetime(name, **options)
          options = options.merge(from: DateTime)
          attribute(name, **options)
        end

        ########################################################################

        def collection_of_attributes
          @collection_of_attributes ||= Collection.new
        end
      end
    end
  end
end
