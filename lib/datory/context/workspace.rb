# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      def attributes
        @attributes ||= Attributes.new(
          context: self,
          incoming_attributes: incoming_attributes,
          collection_of_attributes: collection_of_attributes
        )
      end

      private

      attr_reader :incoming_attributes,
                  :collection_of_attributes

      def _deserialize(
        incoming_attributes:,
        collection_of_attributes:
      )
        deserialize(
          incoming_attributes: incoming_attributes,
          collection_of_attributes: collection_of_attributes
        )
      end

      def deserialize(
        incoming_attributes:,
        collection_of_attributes:,
        **
      )
        @incoming_attributes = incoming_attributes
        @collection_of_attributes = collection_of_attributes
      end
    end
  end
end
