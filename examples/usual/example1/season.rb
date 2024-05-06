# frozen_string_literal: true

module Usual
  module Example1
    class Season < Datory::Base
      uuid :id
      # uuid :serialId, to: :serial_id

      integer :number

      # many :episodes, include: Episode

      date :premieredOn, to: :premiered_on
    end
  end
end
