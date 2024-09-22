# frozen_string_literal: true

module Datory
  module Setters
    module Workspace
      private

      def serialize(model:, collection_of_attributes:, collection_of_setters:)
        super

        collection_of_setters.each do |setter|
          hash = Datory::Attributes::Serialization::Model.to_hash(model)

          model.send(:define_setter, setter.name, setter.block.call(attributes: hash))
        end
      end
    end
  end
end
