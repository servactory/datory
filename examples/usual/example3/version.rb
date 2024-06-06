# frozen_string_literal: true

module Usual
  module Example3
    class Version < Datory::Base
      string! :name

      # NOTE: Must be empty within examples.
      date? :releasedAt, to: :released_at
      date? :endedAt, to: :ended_at
    end
  end
end
