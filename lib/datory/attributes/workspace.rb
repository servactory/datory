# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      private

      def build!(incoming_attributes:, collection_of_attributes:, **)
        super

        # puts
        # puts :incoming_attributes
        # puts incoming_attributes.inspect
        # puts

        # puts
        # puts :collection_of_attributes
        # puts collection_of_attributes.names.inspect
        # puts

        builder_class = Datory::Service::Builder.dup

        # puts
        # puts :builder_class
        # puts builder_class.inspect
        # puts builder_class.__id__.inspect
        # puts

        builder_class.class_eval do
          collection_of_attributes.each do |attribute|
            # puts
            # puts attribute.inspect
            # puts

            input attribute.name,
                  as: attribute.options.fetch(:as, attribute.name),
                  type: attribute.options.fetch(:type),
                  required: attribute.options.fetch(:required, true),
                  prepare: (lambda do |value:|
                    prepare = attribute.options.fetch(:prepare, nil)

                    return prepare.call(value: value) if prepare.is_a?(Proc)

                    value
                  end)
          end

          output :data, type: Hash

          make :build

          private

          def build
            # puts
            # puts :company
            # puts inputs.company.inspect
            # puts

            # inputs.company

            outputs.data = send(:collection_of_inputs).names.to_h do |input_name|
              puts input_name

              [
                input_name,
                inputs.public_send(input_name)
              ]
            end
          end
        end

        builder_class = builder_class.dup

        # puts
        # # puts builder_class.__id__.inspect
        # # puts collection_of_attributes.names.inspect
        # puts builder_class.info.inspect
        # puts builder_class.call!(**incoming_attributes).inspect
        # puts

        # Tools::Unnecessary.find!(self, attributes, collection_of_attributes)
        # Tools::Rules.check!(self, collection_of_attributes)
        # Tools::Validation.validate!(self, attributes, collection_of_attributes)
      end
    end
  end
end
