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

      string :id
      string :firstname, to: :first_name
      string :lastname, to: :last_name
      string :email
      string :birthDate, to: :birth_date, output: ->(value:) { value.to_s }

      one :login, include: UserLogin

      many :addresses, include: UserAddress

      string :phone
      string :website

      one :company, include: UserCompany
    end
  end
end
