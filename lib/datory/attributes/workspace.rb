# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      class ServiceFactory
        def self.create(model_class, class_name, collection_of_attributes) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
          return if model_class.const_defined?(class_name)

          class_sample = Class.new(Datory::Service::Builder) do
            collection_of_attributes.each do |attribute| # rubocop:disable Metrics/BlockLength
              input attribute.name,
                    as: attribute.options.fetch(:as, attribute.name),
                    type: attribute.options.fetch(:type),
                    required: attribute.options.fetch(:required, true),
                    consists_of: attribute.options.fetch(:consists_of, false),
                    prepare: (lambda do |value:|
                      included_class = attribute.options.fetch(:include, nil)
                      return value unless included_class.present?

                      type = attribute.options.fetch(:type, nil)

                      if [Set, Array].include?(type)
                        value.map { |item| included_class.build(**item) }
                      else
                        included_class.build(**value)
                      end
                    end)

              output attribute.name,
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

              make :"assign_#{attribute.name}_output"

              define_method(:"assign_#{attribute.name}_output") do
                outputs.public_send(:"#{attribute.name}=", inputs.public_send(attribute.name))
              end
            end
          end

          model_class.const_set(class_name, class_sample)
        end
      end

      private

      def build!(incoming_attributes:, collection_of_attributes:, **)
        super

        builder_class_name = "GBuilder"

        ServiceFactory.create(self.class, builder_class_name, collection_of_attributes)

        builder_class = "#{self.class.name}::#{builder_class_name}".constantize

        builder_class.call!(**incoming_attributes)

        # Tools::Unnecessary.find!(self, attributes, collection_of_attributes)
        # Tools::Rules.check!(self, collection_of_attributes)
        # Tools::Validation.validate!(self, attributes, collection_of_attributes)
      end
    end
  end
end
