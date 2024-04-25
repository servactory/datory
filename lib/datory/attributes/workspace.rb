# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      private

      def serialize(model:, collection_of_attributes:)
        super

        Serialization::Serializator.serialize(
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def deserialize(incoming_attributes:, collection_of_attributes:)
        super

        Deserialization::ServiceBuilder.build!(self, incoming_attributes, collection_of_attributes)
      end

      def to_model(attributes:)
        super

        attributes.each do |attribute_name, attribute_value|
          define_singleton_method(attribute_name) { attribute_value }
        end
      end
    end
  end
end
