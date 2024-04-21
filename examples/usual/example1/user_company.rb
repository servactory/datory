# frozen_string_literal: true

module Usual
  module Example1
    class UserCompany < Datory::Base
      class ARModel
        attr_accessor :name,
                      :catch_phrase,
                      :bs

        def initialize(name:, catch_phrase:, bs:)
          @name = name
          @catch_phrase = catch_phrase
          @bs = bs
        end
      end

      string :name
      string :catchPhrase, as: :catch_phrase
      string :bs
    end
  end
end
