# frozen_string_literal: true

module Datory
  module Service
    module Exceptions
      class Input < Servactory::Exceptions::Input; end
      class Output < Servactory::Exceptions::Output; end
      class Internal < Servactory::Exceptions::Internal; end

      class Failure < Servactory::Exceptions::Failure; end
    end
  end
end
