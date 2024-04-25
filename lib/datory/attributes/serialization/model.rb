# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class Model
        def self.prepare(...)
          new.prepare(...)
        end

        def prepare(data) # rubocop:disable Metrics/MethodLength
          if data.is_a?(Array)
            data.map do |item|
              if item.is_a?(Hash)
                build(item)
              else
                item
              end
            end
          elsif data.is_a?(Hash)
            build(data)
          else
            data
          end
        end

        def build(attributes = {}) # rubocop:disable Metrics/MethodLength
          attributes.each do |key, value|
            self.class.send(:attr_accessor, key)

            instance_variable_set(:"@#{key}", value)

            if value.is_a?(Array)
              value.map! { |item| Datory::Attributes::Serialization::Model.prepare(item) }
              instance_variable_set(:"@#{key}", value)
            elsif value.is_a?(Hash)
              instance_variable_set(:"@#{key}", Datory::Attributes::Serialization::Model.prepare(value))
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
