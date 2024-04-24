# frozen_string_literal: true

module Datory
  module Attributes
    class Attribute
      attr_reader :name, :options

      def initialize(name, **options)
        @name = name
        @options = options
      end

      def input_options # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
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
              value.map { |item| include_class.build(**item) }
            else
              include_class.build(**value)
            end
          end)
        }

        if (format = options.fetch(:format, nil)).present?
          hash[:format] = format
        end

        hash
      end

      def output_options # rubocop:disable Metrics/MethodLength
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

        if (format = options.fetch(:format, nil)).present?
          hash[:format] = format
        end

        hash
      end
    end
  end
end
