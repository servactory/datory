# frozen_string_literal: true

module Usual
  module Example1
    class Season < Datory::Base
      uuid! :id
      # uuid! :serialId, to: :serial_id

      integer! :number
      string! :code

      # many! :episodes, include: Episode

      date! :premieredOn, to: :premiered_on
      date? :endedOn, to: :ended_on

      # deserialize
      getter :code do |attributes:|
        "s#{attributes.fetch(:number)}"
      end

      # serialize
      setter :code do |attributes:|
        "s#{attributes.fetch(:number)}"
      end
    end
  end
end
