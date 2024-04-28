# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      uuid :id

      string :firstname, to: :first_name
      string :lastname, to: :last_name

      string :email
      string :phone
      string :website

      date :birthDate, to: :birth_date

      one :login, include: UserLogin
      one :company, include: UserCompany

      many :addresses, include: UserAddress
    end
  end
end
