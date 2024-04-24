# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      class ARModel
        attr_accessor :id,
                      :first_name,
                      :last_name,
                      :email,
                      :birth_date,
                      :login,
                      :addresses,
                      :phone,
                      :website,
                      :company

        def initialize(first_name:, last_name:, email:, birth_date:, login:, addresses:, phone:, website:, company:)
          @id = SecureRandom.uuid
          @first_name = first_name
          @last_name = last_name
          @email = email
          @birth_date = birth_date
          @login = login
          @addresses = addresses
          @phone = phone
          @website = website
          @company = company
        end
      end

      ##########################################################################

      uuid :id

      string :firstname, to: :first_name
      string :lastname, to: :last_name

      string :email
      string :phone
      string :website

      string :birthDate, to: :birth_date, as: Date

      one :login, include: UserLogin
      one :company, include: UserCompany

      many :addresses, include: UserAddress
    end
  end
end
