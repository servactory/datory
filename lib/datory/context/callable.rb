# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def serialize(model)
        model = Datory::Attributes::Serialization::HashToObject.prepare(model)

        Datory::Attributes::Serialization::Serializator.serialize(
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def deserialize(json)
        if [Set, Array].include?(json.class)
          json.map do |json_item|
            deserialize(json_item)
          end
        else
          hash = JSON.parse(json.to_json)
          build(**hash)
        end
      end

      def to_model(**attributes)
        context = send(:new)

        attributes.each do |attribute_name, attribute_value|
          context.define_singleton_method(attribute_name) { attribute_value }
        end

        context
      end

      # def build!(attributes = {})
      #   context = send(:new)
      #
      #   _build!(context, **attributes)
      # end

      def build(attributes = {})
        context = send(:new)

        _build!(context, **attributes)
      end

      private

      def _build!(context, **attributes)
        context.send(
          :_build!,
          incoming_attributes: attributes.symbolize_keys,
          collection_of_attributes: collection_of_attributes
        )
      end
    end
  end
end
