# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class ServiceFactory
        TRANSFORMATIONS = {
          Symbol => ->(value) { value.to_sym },
          String => ->(value) { value.to_s },
          Integer => ->(value) { value.to_i },
          Float => ->(value) { value.to_f },
          Date => ->(value) { value.to_s },
          Time => ->(value) { value.to_s },
          DateTime => ->(value) { value.to_s },
          ActiveSupport::Duration => ->(value) { value.iso8601 }
        }.freeze

        private_constant :TRANSFORMATIONS

        def self.create(...)
          new(...).create
        end

        def initialize(model_class, collection_of_attributes)
          @model_class = model_class
          @collection_of_attributes = collection_of_attributes
        end

        def create
          return if @model_class.const_defined?(ServiceBuilder::SERVICE_CLASS_NAME)

          class_sample = create_service_class

          @model_class.const_set(ServiceBuilder::SERVICE_CLASS_NAME, class_sample)
        end

        def create_service_class # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          collection_of_attributes = @collection_of_attributes

          Class.new(Datory::Service::Builder) do
            collection_of_attributes.each do |attribute|
              serialized_name = attribute.name
              deserialized_name = attribute.options.fetch(:to, serialized_name)
              method_name = :"assign_#{serialized_name}_output"

              input deserialized_name, **attribute.input_serialization_options

              output serialized_name, **attribute.output_serialization_options

              make method_name

              define_method(method_name) do
                value = inputs.public_send(deserialized_name)

                value = TRANSFORMATIONS.fetch(value.class, ->(v) { v }).call(value)

                outputs.public_send(:"#{serialized_name}=", value)
              end
            end
          end
        end
      end
    end
  end
end
