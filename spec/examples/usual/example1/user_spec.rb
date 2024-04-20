# frozen_string_literal: true

RSpec.describe Usual::Example1::User do # rubocop:disable RSpec/MultipleMemoizedHelpers
  subject(:perform) { described_class.build!(**attributes) }

  let(:attributes) do
    {
      id: id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      birth_date: birth_date,
      company: company
    }
  end

  let(:id) { SecureRandom.uuid }
  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  let(:email) { "johndoe@example.com" }
  let(:birth_date) { Date.parse("1973-01-22") }
  let(:company) { company_hash }

  let(:company_hash) do
    {
      name: company_name,
      catch_phrase: company_catch_phrase,
      bs: company_bs
    }
  end

  let(:company_name) { "ABC Company" }
  let(:company_catch_phrase) { "Innovative solutions for all your needs" }
  let(:company_bs) { "Marketing" }

  it do
    puts
    puts
    puts :perform
    puts perform.inspect
    puts
    puts
  end
end
