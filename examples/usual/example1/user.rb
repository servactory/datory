# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      # singular :user
      # plural :users

      string :id
      string :firstname, as: :first_name
      string :lastname, as: :last_name
      string :email
      string :birthDate, as: :birth_date

      one :login, to: UserLogin

      many :addresses, to: UserAddress

      string :phone
      string :website

      one :company, to: UserCompany
    end
  end
end
