# frozen_string_literal: true

module Datory
  module Context
    module Workspace
      class Actor
        attr_reader :class_name

        def initialize(context)
          @class_name = context.class.name
        end
      end

      private

      def merge!(attributes)
        attributes.each do |key, value|
          instance_variable_set(:"@#{key}", value)
          self.class.attr_reader(key)
        end

        self
      end
      alias merge merge!

      def keys
        instance_variables.map { |instance_variable| instance_variable.to_s.sub(/^@/, "").to_sym }
      end

      def _serialize(model:, collection_of_attributes:)
        serialize(
          model:,
          collection_of_attributes:
        )
      end

      def _deserialize(incoming_attributes:, collection_of_attributes:)
        deserialize(
          incoming_attributes:,
          collection_of_attributes:
        )
      end

      def _to_model(direction:, attributes:, collection_of_attributes:)
        to_model(
          direction:,
          attributes:,
          collection_of_attributes:
        )
      end

      def serialize(**); end

      def deserialize(**); end

      def to_model(**); end

      # NOTE: To maintain context compatibility in Servactory exceptions.
      def servactory_service_info
        @servactory_service_info ||= self.class::Actor.new(self)
      end
    end
  end
end
