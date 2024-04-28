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
          attribute(
            name,
            to: to.presence || name,
            from: Hash,
            include: include,
            as: [Datory::Result, Hash]
          )
        end

        def many(name, include:, to: nil)
          attribute(
            name,
            to: to.presence || name,
            from: Array,
            consists_of: [Datory::Result, Hash],
            include: include,
            as: Array
          )
        end

        ########################################################################

        def uuid(name, **options)
          options = options.merge(format: :uuid)
          string(name, **options)
        end

        def money(name, **options)
          options_for_cents = options.merge(from: Integer)
          options_for_currency = options.merge(from: [Symbol, String])

          attribute(:"#{name}_cents", **options_for_cents)
          attribute(:"#{name}_currency", **options_for_currency)
        end

        def duration(name, **options)
          options = options.merge(from: String, as: ActiveSupport::Duration) # TODO: Add `format: :duration`
          string(name, **options)
        end

        def date(name, **options)
          options = options.merge(from: String, as: Date) # TODO: Add `format: :date`
          string(name, **options)
        end

        def time(name, **options)
          options = options.merge(from: String, as: Time) # TODO: Add `format: :time`
          string(name, **options)
        end

        def datetime(name, **options)
          options = options.merge(from: String, as: DateTime) # TODO: Add `format: :datetime`
          string(name, **options)
        end

        ########################################################################

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

        ########################################################################

        def collection_of_attributes
          @collection_of_attributes ||= Collection.new
        end
      end
    end
  end
end
