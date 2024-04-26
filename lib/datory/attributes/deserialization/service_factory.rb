# frozen_string_literal: true

module Datory
  module Attributes
    module Deserialization
      class ServiceFactory
        TRANSFORMATIONS = {
          Symbol => ->(value) { value.to_sym },
          String => ->(value) { value.to_s },
          Integer => ->(value) { value.to_i },
          Float => ->(value) { value.to_f },
          Date => ->(value) { Date.parse(value) },
          Time => ->(value) { Time.parse(value) },
          DateTime => ->(value) { DateTime.parse(value) },
          ActiveSupport::Duration => ->(value) { ActiveSupport::Duration.parse(value) }
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
              input_internal_name = attribute.options.fetch(:to, attribute.name)
              method_name = :"assign_#{input_internal_name}_output"

              input attribute.name, **attribute.input_deserialization_options

              output input_internal_name, **attribute.output_deserialization_options

              make method_name

              define_method(method_name) do
                value = inputs.public_send(input_internal_name)

                type_as = attribute.options.fetch(:as, nil)

                value = TRANSFORMATIONS.fetch(type_as, ->(v) { v }).call(value)

                outputs.public_send(:"#{input_internal_name}=", value)
              end
            end
          end
        end
      end
    end
  end
end
