# frozen_string_literal: true

module Datory
  module Info
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def info # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          Datory::Info::Result.new(
            attributes: collection_of_attributes.to_h do |attribute|
              from = {
                name: attribute.from.name,
                types: attribute.from.types,
                min: attribute.from.min,
                max: attribute.from.max,
                consists_of: attribute.from.consists_of,
                format: attribute.from.format
              }

              to = {
                name: attribute.to.name,
                types: attribute.to.types,
                required: attribute.to.required,
                min: attribute.to.min,
                max: attribute.to.max,
                consists_of: attribute.to.consists_of,
                format: attribute.to.format,
                include: attribute.to.include_class
              }

              data = { from: from, to: to }

              [attribute.from.name, data]
            end
          )
        end
      end
    end
  end
end
