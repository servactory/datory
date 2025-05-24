# frozen_string_literal: true

module Datory
  module Service
    class Builder < Base
      TRANSFORMATIONS = {
        SERIALIZATION: {
          Symbol => ->(value, type) { TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type, ->(v) { v }).call(value) },
          String => ->(value, type) { TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type, ->(v) { v }).call(value) },
          Integer => ->(value, type) { TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type, ->(v) { v }).call(value) },
          Float => ->(value, type) { TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type, ->(v) { v }).call(value) },
          Date => ->(value, _type) { value.to_s },
          Time => ->(value, _type) { value.to_s },
          DateTime => ->(value, _type) { value.to_s },
          ActiveSupport::Duration => ->(value, _type) { value.iso8601 }
        },
        DESERIALIZATION: {
          # NOTE: These types do not need to be cast automatically:
          String => lambda(&:to_s),
          # Symbol => ->(value) { value.to_sym },
          # NOTE: These types need to be cast automatically:
          Integer => lambda(&:to_i),
          Float => lambda(&:to_f),
          Date => ->(value) { Date.parse(value) },
          Time => ->(value) { Time.parse(value) },
          DateTime => ->(value) { DateTime.parse(value) },
          ActiveSupport::Duration => ->(value) { ActiveSupport::Duration.parse(value) }
        }
      }.freeze

      private_constant :TRANSFORMATIONS

      def self.prepare_serialization_data_for(attribute) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        serialized_name = attribute.from.name
        deserialized_name = attribute.to.name
        method_name = :"assign_#{serialized_name}_output"

        input deserialized_name, **attribute.input_serialization_options

        output serialized_name, **attribute.output_serialization_options

        make method_name

        define_method(method_name) do
          value = inputs.public_send(deserialized_name)

          type = Array(attribute.from.type).excluding(NilClass).first

          value = TRANSFORMATIONS.fetch(:SERIALIZATION).fetch(value.class, ->(v, _t) { v }).call(value, type)

          outputs.public_send(:"#{serialized_name}=", value)
        end
      end

      def self.prepare_deserialization_data_for(attribute) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        serialized_name = attribute.from.name
        deserialized_name = attribute.to.name
        method_name = :"assign_#{deserialized_name}_output"

        input serialized_name, **attribute.input_deserialization_options

        output deserialized_name, **attribute.output_deserialization_options

        make method_name

        define_method(method_name) do
          value = inputs.public_send(deserialized_name)

          if value.present?
            type = attribute.to.type

            # NOTE: For optional attributes.
            type = (type - [NilClass]).first if type.is_a?(Array)

            value = TRANSFORMATIONS.fetch(:DESERIALIZATION).fetch(type, ->(v) { v }).call(value)
          end

          outputs.public_send(:"#{deserialized_name}=", value)
        end
      end
    end
  end
end
