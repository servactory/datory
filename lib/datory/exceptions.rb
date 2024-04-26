# frozen_string_literal: true

module Datory
  module Exceptions
    class SerializationError < Datory::Service::Exceptions::Input; end
    class DeserializationError < Datory::Service::Exceptions::Input; end
  end
end
