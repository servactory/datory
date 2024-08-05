# frozen_string_literal: true

module Datory
  class Result < Servactory::Result
    IGNORED_KEYS = %i[success? failure?].freeze
    private_constant :IGNORED_KEYS

    def to_hash(result = self)
      result.methods(false).filter do |key|
        !key.in?(IGNORED_KEYS)
      end.to_h do |key| # rubocop:disable Style/MultilineBlockChain
        value = result.public_send(key)

        value = value.except(*IGNORED_KEYS) if value.is_a?(Hash)

        [key.to_s.delete_prefix("@").to_sym, value]
      end.compact
    end
  end
end
