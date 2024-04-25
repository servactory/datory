# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      private

      def serialize(model:, collection_of_attributes:, **)
        super

        Serialization::Serializator.serialize(
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def deserialize(incoming_attributes:, collection_of_attributes:, **)
        super

        Tools::ServiceBuilder.build!(self, incoming_attributes, collection_of_attributes)
      end
    end
  end
end
