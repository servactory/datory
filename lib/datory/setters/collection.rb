# frozen_string_literal: true

module Datory
  module Setters
    class Collection
      extend Forwardable
      def_delegators :@collection, :<<, :each, :merge

      def initialize(collection = Set.new)
        @collection = collection
      end

      # def find_by(name:)
      #   find { |getter| getter.name == name }
      # end
    end
  end
end
