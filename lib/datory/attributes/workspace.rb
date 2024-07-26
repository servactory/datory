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
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def deserialize(incoming_attributes:, collection_of_attributes:)
        super

        Deserialization::ServiceBuilder.build!(self, incoming_attributes, collection_of_attributes)
      end

      def to_model(attributes:, collection_of_attributes:)
        super

        attributes.each do |attribute_name, attribute_value|
          if attribute_value.is_a?(Hash)
            nested_attribute = collection_of_attributes.find_by(name: attribute_name)

            nested_result =
              if nested_attribute.present?
                nested_attribute.to.include_class.to_model(**attribute_value)
              else
                attribute_value
              end

            nested_attribute.to.include_class.instance_variable_set(:"@#{attribute_name}", nested_result)
            nested_attribute.to.include_class.attr_reader(attribute_name)
          else
            instance_variable_set(:"@#{attribute_name}", attribute_value)
            self.class.attr_reader(attribute_name)
          end
        end

        self
      end
    end
  end
end
