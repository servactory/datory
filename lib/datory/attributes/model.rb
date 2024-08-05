# frozen_string_literal: true

module Datory
  module Attributes
    class Model
      def self.build!(...)
        new(...).build!
      end

      def initialize(context, direction, attributes, collection_of_attributes)
        @context = context
        @direction = direction
        @attributes = attributes
        @collection_of_attributes = collection_of_attributes
      end

      def build!
        @collection_of_attributes.each do |attribute|
          attribute_name = @direction.serialization? ? attribute.to.name : attribute.from.name
          attribute_value = @attributes.fetch(attribute_name, nil)

          assign_attribute_for(@context, name: attribute_name, value: attribute_value)
        end

        @context
      end

      private

      def assign_attribute_for(context, name:, value:)
        return if context.instance_variable_defined?(:"@#{name}")

        context.instance_variable_set(:"@#{name}", value)
        context.class.attr_accessor(name)
      end
    end
  end
end
