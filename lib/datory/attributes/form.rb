# frozen_string_literal: true

module Datory
  module Attributes
    class Form
      attr_reader :model

      def initialize(context, model)
        @context = context
        @model = model
      end

      def target
        @context
      end

      def update(**attributes)
        if model_collection?
          raise_misuse "The `update` method cannot be used with a collection. Instead, use the `update_by` method."
        end

        found_keys = model.send(:keys) & attributes.keys

        reset!

        model.send(:merge!, attributes.slice(*found_keys))
      end

      def update_by(index, **attributes) # rubocop:disable Metrics/MethodLength
        unless model_collection?
          raise_misuse "The `update_by` method cannot be used without a collection. Instead, use the `update` method."
        end

        reset!

        model.map!.with_index do |model_item, model_index|
          if model_index == index
            found_keys = model_item.send(:keys) & attributes.keys

            model_item.send(:merge, attributes.slice(*found_keys))
          else
            model_item
          end
        end
      end

      def serialize
        @serialize ||= @context.serialize(model)
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

      def raise_misuse(message)
        raise Datory::Exceptions::MisuseError, message
      end

      def model_collection?
        [Set, Array].include?(model.class)
      end

      def reset!
        @serialize = nil
      end
    end
  end
end
