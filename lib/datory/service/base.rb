# frozen_string_literal: true

module Datory
  module Service
    class Base
      include Servactory::DSL

      configuration do
        input_exception_class Datory::Service::Exceptions::Input
        internal_exception_class Datory::Service::Exceptions::Internal
        output_exception_class Datory::Service::Exceptions::Output

        failure_class Datory::Service::Exceptions::Failure

        result_class Datory::Result
      end
    end
  end
end
