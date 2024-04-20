# frozen_string_literal: true

module Usual
  module Example1
    class UserCompany < Datory::Base
      attribute :name, type: String
      attribute :catch_phrase, type: String
      attribute :bs, type: String
    end
  end
end
