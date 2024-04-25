# frozen_string_literal: true

module Datory
  module Attributes
    class Descriptor
      def self.describe(...)
        new.describe(...)
      end

      def describe(collection_of_attributes:)
        # results = collection_of_attributes.map do |attribute|
        #   [
        #     attribute.name
        #   ].join(" » ")
        # end
        #
        # results.each do |result|
        #   puts result
        # end
        #
        # nil

        headings = []
        rows = []

        headings << "Attribute"
        headings << "From"
        headings << "To"
        headings << "As"

        collection_of_attributes.each do |attribute|
          row = []

          row << attribute.name

          from_type = attribute.options.fetch(:from)

          row << from_type
          row << attribute.options.fetch(:to, attribute.name)
          row << attribute.options.fetch(:as, attribute.options.fetch(:include, from_type))

          rows << row
        end

        Datory::Console.print_table(headings.uniq, rows)
      end
    end
  end
end
