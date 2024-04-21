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
          @birth_date = Date.parse(birth_date)
          @login = login
          @addresses = addresses
          @phone = phone
          @website = website
          @company = company
        end
      end

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
