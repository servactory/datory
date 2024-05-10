# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      def _serialize(model:, collection_of_attributes:)
        serialize(
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def _deserialize(incoming_attributes:, collection_of_attributes:)
        deserialize(
          incoming_attributes: incoming_attributes,
          collection_of_attributes: collection_of_attributes
        )
      end

      def _to_model(attributes:)
        to_model(
          attributes: attributes
        )
      end

      def serialize(model:, collection_of_attributes:, **)
        @model = model
        @collection_of_attributes = collection_of_attributes
      end

      def deserialize(incoming_attributes:, collection_of_attributes:, **)
        @incoming_attributes = incoming_attributes
        @collection_of_attributes = collection_of_attributes
      end

      def to_model(attributes:)
        @attributes = attributes
      end
    end
  end
end
