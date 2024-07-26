# frozen_string_literal: true

module Datory
  module Attributes
    class Model
      def self.build!(...)
        new(...).build!
      end

      def initialize(context, attributes, _collection_of_attributes)
        @context = context
        @attributes = attributes
        # @collection_of_attributes = collection_of_attributes
      end

      def build!
        @attributes.each do |attribute_name, attribute_value|
          if attribute_value.is_a?(Hash)
            # nested_attribute = @collection_of_attributes.find_by(name: attribute_name)
            #
            # nested_result =
            #   if nested_attribute.present?
            #     nested_attribute.to.include_class.to_model(**attribute_value)
            #   else
            #     attribute_value
            #   end
            #
            # assign_attribute_for(nested_attribute.to.include_class, name: attribute_name, value: nested_result)
          else
            assign_attribute_for(@context, name: attribute_name, value: attribute_value)
          end
        end
      end

      private

      def assign_attribute_for(context, name:, value:)
        context.instance_variable_set(:"@#{name}", value)
        context.class.attr_reader(name)
      end
    end
  end
end
