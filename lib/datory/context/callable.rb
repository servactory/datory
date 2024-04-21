# frozen_string_literal: true

module Datory
  module Context
    module Callable
      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      def serialize(model)
        if [Set, Array].include?(model.class)
          model.map do |model_item|
            serialize(model_item)
          end
        else
          collection_of_attributes.to_h do |attribute|
            internal_name = attribute.options.fetch(:as, attribute.name)
            include_class = attribute.options.fetch(:include, nil)
            output_formatter = attribute.options.fetch(:output, nil)

            value = model.public_send(internal_name)

            value =
              if include_class.present?
                type = attribute.options.fetch(:type, nil)

                if [Set, Array].include?(type)
                  value.map { |item| include_class.serialize(item) }
                else
                  include_class.serialize(value)
                end
              elsif output_formatter.is_a?(Proc)
                output_formatter.call(value: value)
              elsif [Date, Time, DateTime].include?(value.class)
                value.to_s
              else
                value
              end

            [attribute.name, value]
          end
        end
      end
      # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

      def deserialize(json)
        if [Set, Array].include?(json.class)
          json.map do |json_item|
            deserialize(json_item)
          end
        else
          hash = JSON.parse(json.to_json)
          build(**hash)
        end
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
