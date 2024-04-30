# frozen_string_literal: true

module Datory
  module Attributes
    class Form
      def initialize(context, model)
        @context = context
        @model = model
      end

      def serialize
        @context.serialize(@model)
      end

      def valid?
        serialize

        true
      rescue Datory::Exceptions::SerializationError
        false
      end
    end
  end
end
