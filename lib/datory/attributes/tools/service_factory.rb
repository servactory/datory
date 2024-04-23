# frozen_string_literal: true

module Datory
  module Attributes
    module Tools
      class ServiceFactory
        def self.create(...)
          new(...).create
        end

        def initialize(model_class, collection_of_attributes)
          @model_class = model_class
          @collection_of_attributes = collection_of_attributes
        end

        # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        def create
          return if @model_class.const_defined?(ServiceBuilder::SERVICE_CLASS_NAME)

          collection_of_attributes = @collection_of_attributes

          class_sample = Class.new(Datory::Service::Builder) do
            collection_of_attributes.each do |attribute| # rubocop:disable Metrics/BlockLength
              input_internal_name = attribute.options.fetch(:to, attribute.name)

              input attribute.name,
                    as: input_internal_name,
                    type: attribute.options.fetch(:type),
                    required: attribute.options.fetch(:required, true),
                    consists_of: attribute.options.fetch(:consists_of, false),
                    prepare: (lambda do |value:|
                      include_class = attribute.options.fetch(:include, nil)
                      return value unless include_class.present?

                      type = attribute.options.fetch(:type, nil)

                      if [Set, Array].include?(type)
                        value.map { |item| include_class.build(**item) }
                      else
                        include_class.build(**value)
                      end
                    end)

              output input_internal_name,
                     consists_of: (
                       if (type = attribute.options.fetch(:consists_of, false)) == Hash
                         Datory::Result
                       else
                         type
                       end
                     ),
                     type: if (type = attribute.options.fetch(:type)) == Hash
                             Datory::Result
                           else
                             type
                           end

              make :"assign_#{input_internal_name}_output"

              define_method(:"assign_#{input_internal_name}_output") do
                outputs.public_send(:"#{input_internal_name}=", inputs.public_send(input_internal_name))
              end
            end

            # output :model, type: Class

            # make :assign_model_name

            # def assign_model_name
            #   model_class_name_array = self.class.name.split("::")
            #   model_class_name_array.pop
            #   model_class_name = model_class_name_array.join("::")
            #   model_class = model_class_name.constantize
            #
            #   outputs.model = model_class
            # end
          end

          @model_class.const_set(ServiceBuilder::SERVICE_CLASS_NAME, class_sample)
        end
        # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      end
    end
  end
end
