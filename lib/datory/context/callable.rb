# frozen_string_literal: true

module Datory
  module Context
    module Callable
      def serialize(model)
        hash = {}

        collection_of_attributes.each do |attribute|
          internal_name = attribute.options.fetch(:as, attribute.name)
          include_class = attribute.options.fetch(:include, nil)

          value = model.public_send(internal_name)

          value =
            if include_class.present?
              type = attribute.options.fetch(:type, nil)

              if [Set, Array].include?(type)
                value.map { |item| include_class.serialize(item) }
              else
                include_class.serialize(value)
              end
            else
              value
            end

          hash[internal_name] = value
        end

        hash
      end

      def deserialize(json)
        hash = JSON.parse(json.to_json)
        build(**hash)
      end

      # def build!(attributes = {})
      #   context = send(:new)
      #
      #   _build!(context, **attributes)
      # end

      def build(attributes = {})
        context = send(:new)

        _build!(context, **attributes)
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
