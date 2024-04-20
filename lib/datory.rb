# frozen_string_literal: true

require "zeitwerk"

require "active_support/all"

require "uri"

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect(
  "dsl" => "DSL"
)
loader.setup

module Datory; end

require "datory/engine" if defined?(Rails::Engine)
