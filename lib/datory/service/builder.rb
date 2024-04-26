# frozen_string_literal: true

module Datory
  module Service
    class Builder < Base
      TRANSFORMATIONS = {
        SERIALIZATION: {
          Symbol => ->(value) { value.to_sym },
          String => ->(value) { value.to_s },
          Integer => ->(value) { value.to_i },
          Float => ->(value) { value.to_f },
          Date => ->(value) { value.to_s },
          Time => ->(value) { value.to_s },
          DateTime => ->(value) { value.to_s },
          ActiveSupport::Duration => ->(value) { value.iso8601 }
        },
        DESERIALIZATION: {
          Symbol => ->(value) { value.to_sym },
          String => ->(value) { value.to_s },
          Integer => ->(value) { value.to_i },
          Float => ->(value) { value.to_f },
          Date => ->(value) { Date.parse(value) },
          Time => ->(value) { Time.parse(value) },
          DateTime => ->(value) { DateTime.parse(value) },
          ActiveSupport::Duration => ->(value) { ActiveSupport::Duration.parse(value) }
        }
      }.freeze

      private_constant :TRANSFORMATIONS

      def self.prepare_serialization_data_for(attribute) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        serialized_name = attribute.name
        deserialized_name = attribute.options.fetch(:to, serialized_name)
        method_name = :"assign_#{serialized_name}_output"

        input deserialized_name, **attribute.input_serialization_options

        output serialized_name, **attribute.output_serialization_options

        make method_name

        define_method(method_name) do
          value = inputs.public_send(deserialized_name)

          value = TRANSFORMATIONS.fetch(:SERIALIZATION).fetch(value.class, ->(v) { v }).call(value)

          outputs.public_send(:"#{serialized_name}=", value)
        end
      end

      def self.prepare_deserialization_data_for(attribute) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        serialized_name = attribute.name
        deserialized_name = attribute.options.fetch(:to, serialized_name)
        method_name = :"assign_#{deserialized_name}_output"

        input serialized_name, **attribute.input_deserialization_options

        output deserialized_name, **attribute.output_deserialization_options

        make method_name

        define_method(method_name) do
          value = inputs.public_send(deserialized_name)

          type_as = attribute.options.fetch(:as, nil)

          value = TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type_as, ->(v) { v }).call(value)

          outputs.public_send(:"#{deserialized_name}=", value)
        end
      end
    end
  end
end
