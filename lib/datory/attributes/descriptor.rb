# frozen_string_literal: true

module Datory
  module Attributes
    class Descriptor
      def self.describe(...)
        new.describe(...)
      end

      def describe(service_class_name:, collection_of_attributes:) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        headings = []
        rows = []

        headings << "Attribute"
        headings << "From"
        headings << "To"
        headings << "As"
        headings << "Include" if collection_of_attributes.include_exist?

        collection_of_attributes.each do |attribute|
          row = []

          row << attribute.name

          from_type = attribute.options.fetch(:from)
          include = attribute.options.fetch(:include, from_type)

          row << from_type
          row << attribute.options.fetch(:to, attribute.name)
          row << attribute.options.fetch(:as, include)

          row << (include if include <= Datory::Base) if collection_of_attributes.include_exist?

          rows << row
        end

        Datory::Console.print_table(title: service_class_name, headings: headings.uniq, rows: rows)
      end
    end
  end
end
