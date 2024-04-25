# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class HashToObject
        def self.build(...)
          new.build(...)
        end

        def build(attributes = {}) # rubocop:disable Metrics/MethodLength
          attributes.each do |key, value|
            self.class.send(:attr_accessor, key)

            instance_variable_set(:"@#{key}", value)

            if value.is_a?(Array)
              value.map! { |item| Datory::Attributes::Serialization::HashToObject.build(item) }
              instance_variable_set(:"@#{key}", value)
            elsif value.is_a?(Hash)
              instance_variable_set(:"@#{key}", Datory::Attributes::Serialization::HashToObject.build(value))
            else
              instance_variable_set(:"@#{key}", value)
            end
          end

          self
        end
      end
    end
  end
end
