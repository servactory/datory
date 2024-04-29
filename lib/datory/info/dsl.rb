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
              [
                attribute.from.name,
                {
                  from: attribute.from.info,
                  to: attribute.to.info
                }
              ]
            end
          )
        end
      end
    end
  end
end
