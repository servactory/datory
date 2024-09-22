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
          context = send(:new, _datory_to_model: false)
          model = Datory::Attributes::Serialization::Model.prepare(model, collection_of_attributes)
          _serialize(context, model)
        end
      rescue Datory::Service::Exceptions::Input,
             Datory::Service::Exceptions::Internal,
             Datory::Service::Exceptions::Output => e
        raise Datory::Exceptions::SerializationError.new(message: e.message)
      end

      def deserialize(data) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/PerceivedComplexity
        prepared_data =
          if data.is_a?(Datory::Base)
            Datory::Attributes::Serialization::Model.to_hash(data)
          elsif data.is_a?(String)
            JSON.parse(data)
          else
            data
          end

        if [Set, Array].include?(prepared_data.class)
          prepared_data.map do |item|
            deserialize(item)
          end
        else
          context = send(:new, _datory_to_model: false)

          additional_attributes =
            collection_of_attributes.external_names.difference(prepared_data.symbolize_keys.keys).to_h do |key|
              [key, nil]
            end

          prepared_data = prepared_data.merge(additional_attributes)

          _deserialize(context, **prepared_data)
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

      def new(_datory_to_model: true, **attributes) # rubocop:disable Lint/UnderscorePrefixedVariableName
        context = super()

        return context unless _datory_to_model

        direction = :serialization

        if defined?(@_datory_model_type) && @_datory_model_type[context.class.name].present?
          direction = @_datory_model_type.fetch(context.class.name)
          @_datory_model_type.delete(context.class.name)
        end

        direction = direction.to_s.inquiry

        _to_model(context, direction: direction, **attributes)
      end

      def describe
        Datory::Attributes::Descriptor.describe(
          service_class_name: name,
          collection_of_attributes: collection_of_attributes
        )
      end
      alias table describe

      def serialization
        assign_datory_model_type(:serialization)

        self
      end

      def deserialization
        assign_datory_model_type(:deserialization)

        self
      end

      private

      def _serialize(context, model)
        context.send(
          :_serialize,
          model: model,
          collection_of_attributes: collection_of_attributes,
          collection_of_setters: collection_of_setters
        )
      end

      def _deserialize(context, **attributes)
        context.send(
          :_deserialize,
          incoming_attributes: attributes.symbolize_keys,
          collection_of_attributes: collection_of_attributes,
          collection_of_getters: collection_of_getters
        )
      end

      def _to_model(context, direction:, **attributes)
        context.send(
          :_to_model,
          direction: direction,
          attributes: attributes,
          collection_of_attributes: collection_of_attributes
        )
      end

      def assign_datory_model_type(type)
        data = { name => type }

        @_datory_model_type =
          defined?(@_datory_model_type) ? @_datory_model_type.merge(data) : data
      end
    end
  end
end
