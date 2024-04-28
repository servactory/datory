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
              type_from = attribute.options.fetch(:from)

              [
                attribute.name,
                {
                  from: type_from,
                  to: attribute.options.fetch(:to, attribute.name),
                  as: attribute.options.fetch(:as, type_from),
                  include: attribute.options.fetch(:include, nil)
                }
              ]
            end
          )
        end
      end
    end
  end
end
