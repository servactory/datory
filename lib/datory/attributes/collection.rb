# frozen_string_literal: true

module Datory
  module Attributes
    class Collection
      extend Forwardable
      def_delegators :@collection, :<<, :each, :map, :merge # :filter, :each, :map, :flat_map, :to_h, :merge, :find

      def initialize(collection = Set.new)
        @collection = collection
      end

      # def only(*names)
      #   Collection.new(filter { |input| names.include?(input.internal_name) })
      # end

      # def except(*names)
      #   Collection.new(filter { |input| !names.include?(input.internal_name) })
      # end

      def names
        map(&:name)
      end

      # def find_by(name:)
      #   find { |input| input.internal_name == name }
      # end
    end
  end
end
