# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      private

      def merge!(attributes)
        attributes.each do |key, value|
          instance_variable_set(:"@#{key}", value)
          self.class.attr_reader(key)
        end

        self
      end
      alias merge merge!

      def keys
        instance_variables.map { |instance_variable| instance_variable.to_s.sub(/^@/, "").to_sym }
      end

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

      def _to_model(direction:, attributes:, collection_of_attributes:)
        to_model(
          direction: direction,
          attributes: attributes,
          collection_of_attributes: collection_of_attributes
        )
      end

      def serialize(**); end

      def deserialize(**); end

      def to_model(**); end
    end
  end
end
