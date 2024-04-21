# frozen_string_literal: true

module Usual
  module Example1
    class User < Datory::Base
      singular :user
      plural :users

      attribute :id, type: String
      attribute :firstname, as: :first_name, type: String
      attribute :lastname, as: :last_name, type: String
      attribute :email, type: String
      attribute :birthDate, as: :birth_date, type: String, required: false

      attribute :login, type: Hash, include: UserLogin

      attribute :addresses, type: Array, consists_of: Hash, include: UserAddress

      attribute :phone, type: String, required: false
      attribute :website, type: String, required: false

      attribute :company, type: Hash, include: UserCompany
    end
  end
end
