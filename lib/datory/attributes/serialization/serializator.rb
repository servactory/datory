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
      end
    end
  end
end
