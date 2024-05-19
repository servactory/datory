# frozen_string_literal: true

module Usual
  module Example4
    class Comment < Datory::Base
      uuid! :id

      uuid? :parentId, to: :parent_id

      string! :content

      datetime? :publishedAt, to: :published_at
    end
  end
end
