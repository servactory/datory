# frozen_string_literal: true

module Datory
  module Attributes
    class Model
      def self.build!(...)
        new(...).build!
      end

      def initialize(context, model_type, attributes, collection_of_attributes)
        @context = context
        @model_type = model_type
        @attributes = attributes
        @collection_of_attributes = collection_of_attributes
      end

      def build!
        @collection_of_attributes.each do |attribute|
          attribute_name = @model_type == :serialization ? attribute.to.name : attribute.from.name
          attribute_value = @attributes.fetch(attribute_name, nil)

          # puts
          # puts @context.class.inspect
          # puts @model_type.inspect
          # puts attribute_name.inspect
          # puts

          if attribute_value.is_a?(Hash)
            # TODO
          else
            assign_attribute_for(@context, name: attribute_name, value: attribute_value)
          end
        end

        # @attributes.each do |attribute_name, attribute_value|
        #   if attribute_value.is_a?(Hash)
        #     # nested_attribute = @collection_of_attributes.find_by(name: attribute_name)
        #     #
        #     # nested_result =
        #     #   if nested_attribute.present?
        #     #     nested_attribute.to.include_class.new(**attribute_value)
        #     #   else
        #     #     attribute_value
        #     #   end
        #     #
        #     # assign_attribute_for(nested_attribute.to.include_class, name: attribute_name, value: nested_result)
        #   else
        #     assign_attribute_for(@context, name: attribute_name, value: attribute_value)
        #   end
        # end

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
