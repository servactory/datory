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
              type_from = attribute.options.fetch(:from)

              options = {
                from: type_from,
                to: attribute.options.fetch(:to, attribute.name),
                as: attribute.options.fetch(:as, type_from),
                min: attribute.options.fetch(:min, nil),
                max: attribute.options.fetch(:max, nil),
                include: attribute.options.fetch(:include, nil)
              }

              [attribute.name, options]
            end
          )
        end
      end
    end
  end
end
