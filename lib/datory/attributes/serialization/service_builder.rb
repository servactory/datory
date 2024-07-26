# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class ServiceBuilder
        SERVICE_CLASS_NAME = "SBuilder"

        def self.build!(...)
          new(...).build!
        end

        def initialize(context, model, collection_of_attributes)
          @context = context
          @model = model
          @collection_of_attributes = collection_of_attributes
        end

        def build!
          ServiceFactory.create(@context.class, @collection_of_attributes)

          attributes = Datory::Attributes::Serialization::Model.to_hash(@model) # FIXME
          attributes = attributes.send(:to_hash) # FIXME

          unnecessary_attributes = attributes.keys.difference(@collection_of_attributes.internal_names)

          unnecessary_attributes.each do |key|
            attributes.delete(key)
          end

          builder_class.call!(**attributes)
        end

        private

        def builder_class
          "#{@context.class.name}::#{SERVICE_CLASS_NAME}".constantize
        end
      end
    end
  end
end
