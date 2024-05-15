# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def form(model)
        Datory::Attributes::Form.new(self, model)
      end

      def serialize(model) # rubocop:disable Metrics/MethodLength
        if [Set, Array].include?(model.class)
          model.map do |model_item|
            serialize(model_item)
          end
        else
          context = send(:new)
          model = Datory::Attributes::Serialization::Model.prepare(model)
          _serialize(context, model)
        end
      rescue Datory::Service::Exceptions::Input,
             Datory::Service::Exceptions::Internal,
             Datory::Service::Exceptions::Output => e
        raise Datory::Exceptions::SerializationError.new(message: e.message)
      end

      def deserialize(json) # rubocop:disable Metrics/MethodLength
        # TODO: Need to improve this place by adding more checks and an error exception.
        parsed_data = json.is_a?(String) ? JSON.parse(json) : json

        if [Set, Array].include?(parsed_data.class)
          parsed_data.map do |item|
            deserialize(item)
          end
        else
          context = send(:new)

          _deserialize(context, **parsed_data)
        end
      rescue Datory::Service::Exceptions::Input,
             Datory::Service::Exceptions::Internal,
             Datory::Service::Exceptions::Output => e
        raise Datory::Exceptions::DeserializationError.new(message: e.message)
      rescue JSON::ParserError => e
        # TODO: Needs to be moved to I18n
        message = "Failed to parse data for deserialization: #{e.message}"

        raise Datory::Exceptions::DeserializationError.new(message: message, meta: { original_exception: e })
      end

      def to_model(**attributes)
        context = send(:new)

        _to_model(context, **attributes)
      end

      def describe
        Datory::Attributes::Descriptor.describe(
          service_class_name: name,
          collection_of_attributes: collection_of_attributes
        )
      end
      alias table describe

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

      def _to_model(context, **attributes)
        context.send(
          :_to_model,
          attributes: attributes
        )
      end
    end
  end
end
