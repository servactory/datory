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
        headings << "Include" if collection_of_attributes.include_class_exist?

        collection_of_attributes.each do |attribute|
          row = []

          row << attribute.from.name
          row << attribute.from.type
          row << attribute.to.name
          row << attribute.to.type

          include_class = attribute.to.include_class.presence || attribute.from.type
          row << (include_class if include_class <= Datory::Base) if collection_of_attributes.include_class_exist?

          rows << row
        end

        Datory::Console.print_table(title: service_class_name, headings: headings.uniq, rows: rows)
      end
    end
  end
end
