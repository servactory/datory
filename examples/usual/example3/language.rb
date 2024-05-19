# frozen_string_literal: true

module Usual
  module Example3
    class Language < Datory::Base
      uuid! :id

      string! :name

      # TODO: Need to prepare this example:
      # {
      #   versions: {
      #     current: {},
      #     maintenance: {
      #       normal: {
      #         last: {},
      #         all: []
      #       },
      #       security: {
      #         last: {},
      #         all: []
      #       }
      #     },
      #     eol: {
      #       last: {},
      #       all: []
      #     }
      #   }
      # }

      one! :currentVersion, to: :current, include: Version
      one? :lastEOLVersion, to: :last_eol, include: Version

      many? :previousVersions, to: :previous, include: Version
    end
  end
end
