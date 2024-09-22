# frozen_string_literal: true

module Usual
  module Example3
    class Language < Datory::Base
      uuid! :id

      string! :name
      string? :fullName, to: :full_name

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

      # deserialize
      getter :fullName do |**|
        nil
      end

      # serialize
      setter :full_name do |attributes:|
        language_name = attributes.fetch(:name)
        current_version_name = attributes.dig(:current, :name)

        next language_name if current_version_name.blank?

        "#{language_name} (#{current_version_name})"
      end
    end
  end
end
