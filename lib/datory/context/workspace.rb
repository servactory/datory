# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      def _serialize(model:, collection_of_attributes:, collection_of_setters:)
        serialize(
          model: model,
          collection_of_attributes: collection_of_attributes,
          collection_of_setters: collection_of_setters
        )
      end

      def _deserialize(incoming_attributes:, collection_of_attributes:, collection_of_getters:)
        deserialize(
          incoming_attributes: incoming_attributes,
          collection_of_attributes: collection_of_attributes,
          collection_of_getters: collection_of_getters
        )
      end

      def _to_model(attributes:)
        to_model(
          attributes: attributes
        )
      end

      def serialize(model:, collection_of_attributes:, collection_of_setters:, **)
        @model = model
        @collection_of_attributes = collection_of_attributes
        @collection_of_setters = collection_of_setters
      end

      def deserialize(incoming_attributes:, collection_of_attributes:, collection_of_getters:, **)
        @incoming_attributes = incoming_attributes
        @collection_of_attributes = collection_of_attributes
        @collection_of_getters = collection_of_getters
      end

      def to_model(attributes:)
        @attributes = attributes
      end
    end
  end
end
