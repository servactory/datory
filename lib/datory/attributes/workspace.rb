# frozen_string_literal: true

module Datory
  module Attributes
    module Workspace
      private

      def build!(incoming_attributes:, collection_of_attributes:, **)
        super

        Tools::ServiceBuilder.build!(self, incoming_attributes, collection_of_attributes)
      end
    end
  end
end
