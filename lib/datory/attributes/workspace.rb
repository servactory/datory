# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      private

      def serialize(model:, collection_of_attributes:)
        super

        return nil if model.nil? # NOTE: When `one` is optional and not passed

        model = Serialization::ServiceBuilder.build!(self, model, collection_of_attributes)

        Serialization::Serializator.serialize(
          model:,
          collection_of_attributes:
        )
      end

      def deserialize(incoming_attributes:, collection_of_attributes:)
        super

        Deserialization::ServiceBuilder.build!(self, incoming_attributes, collection_of_attributes)
      end

      def to_model(direction:, attributes:, collection_of_attributes:)
        super

        Model.build!(self, direction, attributes, collection_of_attributes)

        self
      end
    end
  end
end
