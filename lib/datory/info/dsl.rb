# frozen_string_literal: true

module Datory
  module Info
    module DSL
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def info # rubocop:disable Metrics/MethodLength
          Datory::Info::Result.new(
            attributes: collection_of_attributes.to_h do |attribute|
              type_from = attribute.type_from

              options = {
                from: type_from,
                to: attribute.name_to,
                as: attribute.type_to,
                min: attribute.min,
                max: attribute.max,
                format: {
                  from: attribute.format_from,
                  to: attribute.format_to
                },
                include: attribute.include_class
              }

              [attribute.name, options]
            end
          )
        end
      end
    end
  end
end
