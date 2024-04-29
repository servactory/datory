# frozen_string_literal: true

module Datory
  module Attributes
    module Serialization
      class Serializator
        def self.serialize(model:, collection_of_attributes:)
          new(collection_of_attributes: collection_of_attributes).serialize(model: model)
        end

        def initialize(collection_of_attributes:)
          @collection_of_attributes = collection_of_attributes
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        def serialize(model:)
          if [Set, Array].include?(model.class)
            model.map do |nested_model|
              serialize(model: nested_model)
            end
          else
            @collection_of_attributes.to_h do |attribute|
              include_class = attribute.to.include_class
              # output_formatter = attribute.options.fetch(:output, nil) # TODO

              value = model.public_send(attribute.from.name)

              value =
                if include_class.present?
                  if [Set, Array].include?(attribute.from.type)
                    value.map { |item| include_class.serialize(item) }
                  else
                    include_class.serialize(value)
                  end
                # elsif output_formatter.is_a?(Proc) # TODO
                #   output_formatter.call(value: value)
                elsif [Date, Time, DateTime].include?(value.class)
                  value.to_s
                elsif value.instance_of?(ActiveSupport::Duration)
                  value.iso8601
                else
                  value
                end

              [attribute.from.name, value]
            end
          end
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      end
    end
  end
end
