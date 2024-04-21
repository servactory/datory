# frozen_string_literal: true

module Datory
  module Attributes
    module Tools
      class ServiceBuilder
        SERVICE_CLASS_NAME = "Builder"

        def self.build!(...)
          new(...).build!
        end

        def initialize(context, incoming_attributes, collection_of_attributes)
          @context = context
          @incoming_attributes = incoming_attributes
          @collection_of_attributes = collection_of_attributes
        end

        def build!
          ServiceFactory.create(@context.class, @collection_of_attributes)

          builder_class.call!(**@incoming_attributes)
        end

        private

        def builder_class
          "#{@context.class.name}::#{SERVICE_CLASS_NAME}".constantize
        end
      end
    end
  end
end
