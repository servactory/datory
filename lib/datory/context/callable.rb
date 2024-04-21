# frozen_string_literal: true

module Datory
  module Context
    module Callable
      # def build!(attributes = {})
      #   context = send(:new)
      #
      #   _build!(context, **attributes)
      # end

      def build(attributes = {})
        context = send(:new)

        _build!(context, **attributes)
      end

      def deserialize(json)
        hash = JSON.parse(json.to_json)
        build(**hash)
      end

      private

      def _build!(context, **attributes)
        context.send(
          :_build!,
          incoming_attributes: attributes.symbolize_keys,
          collection_of_attributes: collection_of_attributes
        )
      end
    end
  end
end
