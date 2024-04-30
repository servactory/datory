# frozen_string_literal: true

module Datory
  module Exceptions
    class Base < StandardError; end
    class SerializationError < Datory::Service::Exceptions::Input; end
    class DeserializationError < Datory::Service::Exceptions::Input; end
    class MisuseError < Base; end
  end
end
