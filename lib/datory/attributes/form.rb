# frozen_string_literal: true

module Datory
  module Attributes
    class Form
      def initialize(context, model)
        @context = context
        @model = model
      end

      def update(**attributes)
        if [Set, Array].include?(@model.class)
          raise ArgumentError, "The `update` method cannot be used with a collection"
        end

        found_keys = @model.keys & attributes.keys

        reset!

        @model.merge!(attributes.slice(*found_keys))
      end

      def serialize
        @serialize ||= @context.serialize(@model)
      end

      def valid?
        serialize

        true
      rescue Datory::Exceptions::SerializationError
        false
      end

      def invalid?
        !valid?
      end

      private

      def reset!
        @serialize = nil
      end
    end
  end
end
