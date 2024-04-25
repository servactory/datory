# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def serialize(model)
        model = Datory::Attributes::Serialization::Model.prepare(model)

        context = send(:new)

        _serialize(context, model)
      end

      def deserialize(json)
        if [Set, Array].include?(json.class)
          json.map do |json_item|
            deserialize(json_item)
          end
        else
          context = send(:new)
          hash = JSON.parse(json.to_json)
          _deserialize(context, **hash)
        end
      end

      def to_model(**attributes)
        context = send(:new)

        attributes.each do |attribute_name, attribute_value|
          context.define_singleton_method(attribute_name) { attribute_value }
        end

        context
      end

      def describe
        Datory::Attributes::Descriptor.describe(
          collection_of_attributes: collection_of_attributes
        )
      end

      private

      def _serialize(context, model)
        context.send(
          :_serialize,
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def _deserialize(context, **attributes)
        context.send(
          :_deserialize,
          incoming_attributes: attributes.symbolize_keys,
          collection_of_attributes: collection_of_attributes
        )
      end
    end
  end
end
