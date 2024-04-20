# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def build!(attributes = {})
        context = send(:new)

        _build!(context, **attributes)

        #   Servactory::Result.success_for(context: context)
        # rescue config.success_class => e
        #   Servactory::Result.success_for(context: e.context)
      end

      def build(attributes = {})
        context = send(:new)

        _build!(context, **attributes)

        #   Servactory::Result.success_for(context: context)
        # rescue config.success_class => e
        #   Servactory::Result.success_for(context: e.context)
        # rescue config.failure_class => e
        #   Servactory::Result.failure_for(context: context, exception: e)
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
