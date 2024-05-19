# frozen_string_literal: true

module Datory
  module Attributes
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
        base.include(Workspace)
      end

      module ClassMethods # rubocop:disable Metrics/ModuleLength
        def inherited(child)
          super

          child.send(:collection_of_attributes).merge(collection_of_attributes)
        end

        private

        def attribute(name, **options)
          collection_of_attributes << Attribute.new(name, **options)
        end

        ########################################################################

        def one!(name, include:, to: nil)
          attribute(
            name,
            to: to.presence || name,
            from: Hash,
            include: include,
            as: [Datory::Result, Hash]
          )
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `one!`
        alias one one!

        def one?(name, include:, to: nil)
          attribute(
            name,
            to: to.presence || name,
            from: [Hash, NilClass],
            include: include,
            as: [Datory::Result, Hash, NilClass],
            required: false
          )
        end

        def many!(name, include:, to: nil)
          attribute(
            name,
            to: to.presence || name,
            from: Array,
            consists_of: [Datory::Result, Hash],
            include: include,
            as: Array
          )
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `many!`
        alias many many!

        def many?(name, include:, to: nil)
          attribute(
            name,
            to: to.presence || name,
            from: Array,
            consists_of: [Datory::Result, Hash],
            include: include,
            as: Array,
            required: false,
            default: []
          )
        end

        ########################################################################

        def uuid!(name, **options)
          options = options.slice(:to)
          options = options.merge(format: :uuid)
          string!(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `uuid!`
        alias uuid uuid!

        # TODO: Need to implement an optional version for `uuid`.

        def money!(name, **options)
          options = options.slice(:to)

          integer! :"#{name}_cents", **options
          string! :"#{name}_currency", **options
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `money!`
        alias money money!

        def money?(name, **options)
          options = options.slice(:to)

          integer? :"#{name}_cents", **options
          string? :"#{name}_currency", **options
        end

        def duration!(name, **options)
          options = options.slice(:to)
          options = options.merge(from: String, as: ActiveSupport::Duration, format: { from: :duration })
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `duration!`
        alias duration duration!

        def duration?(name, **options)
          options = options.slice(:to)
          options = options.merge(
            from: [String, NilClass],
            as: [ActiveSupport::Duration, NilClass],
            format: { from: :duration },
            required: false
          )
          attribute(name, **options)
        end

        def date!(name, **options)
          options = options.slice(:to)
          options = options.merge(from: String, as: Date, format: { from: :date })
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `date!`
        alias date date!

        def date?(name, **options)
          options = options.slice(:to)
          options = options.merge(from: [String, NilClass], as: Date, format: { from: :date }, required: false)
          attribute(name, **options)
        end

        def time!(name, **options)
          options = options.slice(:to)
          options = options.merge(from: String, as: Time, format: { from: :time })
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `time!`
        alias time time!

        # TODO: Need to implement an optional version for `time`.

        def datetime!(name, **options)
          options = options.slice(:to)
          options = options.merge(from: String, as: DateTime, format: { from: :datetime })
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `datetime!`
        alias datetime datetime!

        # TODO: Need to implement an optional version for `datetime`.

        ########################################################################

        def string!(name, **options)
          options = options.merge(from: String)
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `string!`
        alias string string!

        def string?(name, **options)
          options = options.merge(from: [String, NilClass], as: [String, NilClass], required: false)
          attribute(name, **options)
        end

        def integer!(name, **options)
          options = options.merge(from: Integer)
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `integer!`
        alias integer integer!

        def integer?(name, **options)
          options = options.merge(from: [Integer, NilClass], as: [Integer, NilClass], required: false)
          attribute(name, **options)
        end

        def float!(name, **options)
          options = options.merge(from: Float)
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `float!`
        alias float float!

        def float?(name, **options)
          options = options.merge(from: [Float, NilClass], as: [Float, NilClass], required: false)
          attribute(name, **options)
        end

        def boolean!(name, **options)
          options = options.merge(from: [TrueClass, FalseClass])
          attribute(name, **options)
        end
        # NOTE: This will most likely be marked as deprecated in the future in favor of `boolean!`
        alias boolean boolean!

        ########################################################################

        def collection_of_attributes
          @collection_of_attributes ||= Collection.new
        end
      end
    end
  end
end
