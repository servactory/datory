# frozen_string_literal: true

module Datory
  module Attributes
    module Deserialization
      class ServiceFactory
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

              input attribute.name, **attribute.input_options

              output input_internal_name, **attribute.output_options

              make :"assign_#{input_internal_name}_output"

              define_method(:"assign_#{input_internal_name}_output") do
                value = inputs.public_send(input_internal_name)

                option_as = attribute.options.fetch(:as, nil)

                value = Datory::Utils.transform_value_with(value, option_as)

                outputs.public_send(:"#{input_internal_name}=", value)
              end
            end
          end
        end
      end
    end
  end
end
