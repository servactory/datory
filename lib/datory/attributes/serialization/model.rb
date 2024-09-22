# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class Model
        def self.prepare(...)
          new.prepare(...)
        end

        def self.to_hash(...)
          new.to_hash(...)
        end

        def prepare(data)
          if data.is_a?(Hash)
            build(data.deep_dup)
          else
            data
          end
        end

        def to_hash(data)
          if data.is_a?(Datory::Attributes::Serialization::Model) || data.is_a?(Datory::Base)
            parse(data)
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

        def add(key, value)
          self.class.send(:attr_accessor, key)

          instance_variable_set(:"@#{key}", value)

          self
        end

        def parse(data) # rubocop:disable Metrics/MethodLength
          data.instance_variables.to_h do |key|
            value = data.instance_variable_get(key)

            value =
              if value.is_a?(Set) || value.is_a?(Array)
                value.map { |item| Datory::Attributes::Serialization::Model.to_hash(item) }
              elsif value.is_a?(Datory::Attributes::Serialization::Model) || value.is_a?(Datory::Base)
                Datory::Attributes::Serialization::Model.to_hash(value)
              else
                value
              end

            [key.to_s.delete_prefix("@").to_sym, value]
          end
        end
      end
    end
  end
end
