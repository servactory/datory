# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute # rubocop:disable Metrics/ClassLength
      attr_reader :name, :options

      def initialize(name, **options)
        @name = name
        @options = prepare_options(options)
      end

      def prepare_options(options)
        if (format = options.fetch(:format, nil)).present?
          options[:format] = if format.is_a?(Hash)
                               {
                                 from: format.fetch(:from),
                                 to: format.fetch(:to)
                               }
                             else
                               {
                                 from: format,
                                 to: format
                               }
                             end
        end

        options
      end

      def input_serialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        hash = {
          as: options.fetch(:to, name),
          type: options.fetch(:as, options.fetch(:from)),
          required: options.fetch(:required, true),
          consists_of: options.fetch(:consists_of, false)
        }

        if (min = options.fetch(:min, nil)).present?
          hash[:min] = min
        end

        if (max = options.fetch(:max, nil)).present?
          hash[:max] = max
        end

        if (format = options.dig(:format, :from)).present?
          hash[:format] = format
        end

        hash
      end

      def input_deserialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        hash = {
          as: options.fetch(:to, name),
          type: options.fetch(:from),
          required: options.fetch(:required, true),
          consists_of: options.fetch(:consists_of, false),
          prepare: (lambda do |value:|
            include_class = options.fetch(:include, nil)
            return value unless include_class.present?

            from_type = options.fetch(:from, nil)

            if [Set, Array].include?(from_type)
              value.map { |item| include_class.deserialize(**item) }
            else
              include_class.deserialize(**value)
            end
          end)
        }

        if (min = options.fetch(:min, nil)).present?
          hash[:min] = min
        end

        if (max = options.fetch(:max, nil)).present?
          hash[:max] = max
        end

        if (format = options.dig(:format, :from)).present?
          hash[:format] = format
        end

        hash
      end

      def output_serialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
        hash = {
          consists_of: if (consists_of_type = options.fetch(:consists_of, false)) == Hash
                         Datory::Result
                       else
                         consists_of_type
                       end,
          type: if (as_type = options.fetch(:as, options.fetch(:from))) == Datory::Result
                  Hash
                elsif (from_type = options.fetch(:from)).present?
                  from_type
                else
                  as_type
                end
        }

        if (min = options.fetch(:min, nil)).present?
          hash[:min] = min
        end

        if (max = options.fetch(:max, nil)).present?
          hash[:max] = max
        end

        if (format = options.dig(:format, :to)).present?
          hash[:format] = format
        end

        hash
      end

      def output_deserialization_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
        hash = {
          consists_of: if (consists_of_type = options.fetch(:consists_of, false)) == Hash
                         Datory::Result
                       else
                         consists_of_type
                       end,
          type: if (from_type = options.fetch(:from)) == Hash
                  Datory::Result
                elsif (option_as = options.fetch(:as, nil)).present?
                  option_as
                else
                  from_type
                end
        }

        if (min = options.fetch(:min, nil)).present?
          hash[:min] = min
        end

        if (max = options.fetch(:max, nil)).present?
          hash[:max] = max
        end

        if (format = options.dig(:format, :from)).present?
          hash[:format] = format
        end

        hash
      end
    end
  end
end
