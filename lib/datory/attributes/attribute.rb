# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute
      attr_reader :name,
                  :name_to,
                  :type_from,
                  :type_to,
                  :required,
                  :consists_of,
                  :min,
                  :max,
                  :format_from,
                  :format_to,
                  :include_class

      def initialize(name, **options)
        @name = name
        @name_to = options.fetch(:to, name)

        @type_from = options.fetch(:from)
        @type_to = options.fetch(:as, type_from)

        @required = options.fetch(:required, true)

        @consists_of = options.fetch(:consists_of, false)

        @min = options.fetch(:min, nil)
        @max = options.fetch(:max, nil)

        prepare_format_from_options(options)

        @include_class = options.fetch(:include, nil)
      end

      def prepare_format_from_options(options)
        return if (format = options.fetch(:format, nil)).nil?

        if format.is_a?(Hash)
          @format_from = format.fetch(:from, nil)
          @format_to = format.fetch(:to, nil)
        else
          @format_from = format
          @format_to = format
        end
      end

      ##########################################################################

      def input_serialization_options
        hash = {
          as: name_to,
          type: type_to,
          required: required,
          consists_of: consists_of
        }

        hash[:min] = min if min.present?

        hash[:max] = max if max.present?

        hash[:format] = format_to if format_to.present?

        hash
      end

      def output_serialization_options # rubocop:disable Metrics/AbcSize
        hash = {
          consists_of: consists_of == Hash ? Datory::Result : consists_of,
          type: type_to == Datory::Result ? Hash : type_from
        }

        hash[:min] = min if min.present?

        hash[:max] = max if max.present?

        hash[:format] = format_from if format_from.present?

        hash
      end

      ##########################################################################

      def input_deserialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        hash = {
          as: name_to,
          type: type_from,
          required: required,
          consists_of: consists_of,
          prepare: (lambda do |value:|
            return value unless include_class.present?

            if [Set, Array].include?(type_from)
              value.map { |item| include_class.deserialize(**item) }
            else
              include_class.deserialize(**value)
            end
          end)
        }

        hash[:min] = min if min.present?

        hash[:max] = max if max.present?

        hash[:format] = format_from if format_from.present?

        hash
      end

      def output_deserialization_options # rubocop:disable Metrics/AbcSize
        hash = {
          consists_of: consists_of == Hash ? Datory::Result : consists_of,
          type: type_from == Hash ? Datory::Result : type_to
        }

        hash[:min] = min if min.present?

        hash[:max] = max if max.present?

        hash[:format] = format_to if format_to.present?

        hash
      end
    end
  end
end
