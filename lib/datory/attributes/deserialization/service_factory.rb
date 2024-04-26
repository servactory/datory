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

        def create_service_class
          collection_of_attributes = @collection_of_attributes

          Class.new(Datory::Service::Builder) do
            collection_of_attributes.each do |attribute|
              prepare_deserialization_data_for(attribute)
            end
          end
        end
      end
    end
  end
end
