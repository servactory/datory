# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute
      class Work
        attr_accessor :format
        attr_reader :name, :types, :consists_of, :min, :max

        def initialize(name:, types:, consists_of:, min:, max:)
          @name = name
          @types = types # Array(types) TODO
          @consists_of = consists_of
          @min = min
          @max = max
          @format = nil
        end
      end

      class From < Work; end

      class To < Work
        attr_reader :required,
                    :include_class

        def initialize(name:, types:, required:, consists_of:, min:, max:, include_class:)
          @required = required
          @include_class = include_class

          super(name: name, types: types, consists_of: consists_of, min: min, max: max)
        end
      end

      attr_reader :from,
                  :to

      def initialize(name, **options) # rubocop:disable Metrics/MethodLength
        @from = From.new(
          name: name,
          types: options.fetch(:from),
          consists_of: options.fetch(:consists_of, false),
          min: options.fetch(:min, nil),
          max: options.fetch(:max, nil)
        )

        @to = To.new(
          name: options.fetch(:to, name),
          types: options.fetch(:as, @from.types),
          # TODO: It is necessary to implement NilClass support for optional
          required: options.fetch(:required, true),
          consists_of: @from.consists_of,
          min: @from.min,
          max: @from.max,
          include_class: options.fetch(:include, nil)
        )

        prepare_format_from_options(options)
      end

      def prepare_format_from_options(options)
        return if (format = options.fetch(:format, nil)).nil?

        if format.is_a?(Hash)
          @from.format = format.fetch(:from, nil)
          @to.format = format.fetch(:to, nil)
        else
          @from.format = format
          @to.format = format
        end
      end

      ##########################################################################

      def input_serialization_options # rubocop:disable Metrics/AbcSize
        hash = {
          as: to.name,
          type: to.types,
          required: to.required,
          consists_of: to.consists_of
        }

        hash[:min] = to.min if to.min.present?

        hash[:max] = to.max if to.max.present?

        hash[:format] = to.format if to.format.present?

        hash
      end

      def output_serialization_options # rubocop:disable Metrics/AbcSize
        hash = {
          consists_of: to.consists_of == Hash ? Datory::Result : from.consists_of,
          type: to.types == Datory::Result ? Hash : from.types
        }

        hash[:min] = from.min if from.min.present?

        hash[:max] = from.max if from.max.present?

        hash[:format] = from.format if from.format.present?

        hash
      end

      ##########################################################################

      def input_deserialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        hash = {
          as: to.name,
          type: from.types,
          required: to.required,
          consists_of: from.consists_of,
          prepare: (lambda do |value:|
            return value unless to.include_class.present?

            if [Set, Array].include?(from.types)
              value.map { |item| to.include_class.deserialize(**item) }
            else
              to.include_class.deserialize(**value)
            end
          end)
        }

        hash[:min] = from.min if from.min.present?

        hash[:max] = from.max if from.max.present?

        hash[:format] = from.format if from.format.present?

        hash
      end

      def output_deserialization_options # rubocop:disable Metrics/AbcSize
        hash = {
          consists_of: from.consists_of == Hash ? Datory::Result : to.consists_of,
          type: from.types == Hash ? Datory::Result : to.types
        }

        hash[:min] = to.min if to.min.present?

        hash[:max] = to.max if to.max.present?

        hash[:format] = to.format if to.format.present?

        hash
      end
    end
  end
end
