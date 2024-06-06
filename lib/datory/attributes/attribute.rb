# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute
      attr_reader :from, :to

      def initialize(name, **options) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        @from = Options::From.new(
          name: name,
          type: options.fetch(:from),
          consists_of: options.fetch(:consists_of, false),
          min: options.fetch(:min, nil),
          max: options.fetch(:max, nil),
          format: options.fetch(:format, nil)
        )

        @to = Options::To.new(
          name: options.fetch(:to, name),
          type: options.fetch(:as, @from.type),
          # TODO: It is necessary to implement NilClass support for optional
          required: options.fetch(:required, true),
          default: options.fetch(:default, nil),
          consists_of: @from.consists_of,
          min: @from.min,
          max: @from.max,
          format: options.fetch(:format, nil),
          include_class: options.fetch(:include, nil)
        )
      end

      ##########################################################################

      def input_serialization_options # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
        hash = {
          as: to.name,
          type: to.type,
          required: to.required,
          default: to.default,
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
          type: to.type == Datory::Result ? Hash : from.type
        }

        hash[:min] = from.min if from.min.present?

        hash[:max] = from.max if from.max.present?

        hash[:format] = from.format if from.format.present?

        hash
      end

      ##########################################################################

      def input_deserialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        hash = {
          as: to.name,
          type: from.type,
          required: to.required,
          default: to.default,
          consists_of: from.consists_of,
          prepare: (lambda do |value:|
            return value unless to.include_class.present?

            if [Set, Array].include?(from.type)
              value.map { |item| to.include_class.deserialize(**item) }
            else
              return nil if value.nil? # NOTE: When `one` is optional and not passed

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
          type: from.type == Hash ? Datory::Result : to.type
        }

        hash[:min] = to.min if to.min.present?

        hash[:max] = to.max if to.max.present?

        hash[:format] = to.format if to.format.present?

        hash
      end
    end
  end
end
