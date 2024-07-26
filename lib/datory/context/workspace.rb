# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      private

      def to_hash(from = instance_variables)
        from.to_h do |name|
          value = instance_variable_get(name)

          new_value = if value.is_a?(Set) || value.is_a?(Array)
                        value.map { |nested_value| nested_value.send(:to_hash) }
                      elsif value.is_a?(Datory::Base)
                        value.send(:to_hash)
                      else
                        value
                      end

          [name.to_s.sub(/^@/, "").to_sym, new_value]
        end
      end

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

      def delete(key)
        remove_instance_variable(:"@#{key}")
      end

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

      def _to_model(attributes:, collection_of_attributes:)
        to_model(
          attributes: attributes,
          collection_of_attributes: collection_of_attributes
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

      def to_model(**); end
    end
  end
end
