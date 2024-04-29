# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def serialize!(model) # rubocop:disable Metrics/MethodLength
        if [Set, Array].include?(model.class)
          model.map do |model_item|
            serialize!(model_item)
          end
        else
          context = send(:new)
          model = Datory::Attributes::Serialization::Model.prepare(model)
          _serialize!(context, model)
        end
      rescue Datory::Service::Exceptions::Input,
             Datory::Service::Exceptions::Internal,
             Datory::Service::Exceptions::Output => e
        raise Datory::Exceptions::SerializationError.new(message: e.message)
      end

      def deserialize!(json) # rubocop:disable Metrics/MethodLength
        if [Set, Array].include?(json.class)
          json.map do |json_item|
            deserialize!(json_item)
          end
        else
          context = send(:new)
          hash = JSON.parse(json.to_json)

          _deserialize!(context, **hash)
        end
      rescue Datory::Service::Exceptions::Input,
             Datory::Service::Exceptions::Internal,
             Datory::Service::Exceptions::Output => e
        raise Datory::Exceptions::DeserializationError.new(message: e.message)
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

      private

      def _serialize!(context, model)
        context.send(
          :_serialize!,
          model: model,
          collection_of_attributes: collection_of_attributes
        )
      end

      def _deserialize!(context, **attributes)
        context.send(
          :_deserialize!,
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
