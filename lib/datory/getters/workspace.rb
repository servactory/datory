# frozen_string_literal: true

module Datory
  module Getters
    module Workspace
      private

      def deserialize(incoming_attributes:, collection_of_attributes:, collection_of_getters:)
        super

        collection_of_getters.each do |getter|
          incoming_attributes.merge!(getter.name => getter.block.call(attributes: incoming_attributes))
        end
      end
    end
  end
end
