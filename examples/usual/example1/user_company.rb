# frozen_string_literal: true

module Usual
  module Example1
    class UserCompany < Datory::Base
      string :name
      string :catchPhrase, to: :catch_phrase
      string :bs
    end
  end
end
