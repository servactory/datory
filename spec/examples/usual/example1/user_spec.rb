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
      addresses: addresses,
      phone: phone,
      website: website,
      company: company
    }
  end

  let(:id) { SecureRandom.uuid }
  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  let(:email) { "johndoe@example.com" }
  let(:birth_date) { Date.parse("1973-01-22") }
  let(:addresses) { addresses_array }
  let(:phone) { "(555) 555-1234" }
  let(:website) { "www.johndoe.com" }
  let(:company) { company_hash }

  let(:addresses_array) do
    [
      address_hash
    ]
  end

  let(:address_hash) do
    {
      street: "123 Main Street",
      suite: "Apt. 4",
      city: "Anytown",
      zip_code: "12345-6789",
      geo: {
        latitude: "42.1234",
        longitude: "-71.2345"
      }
    }
  end

  let(:company_hash) do
    {
      name: "ABC Company",
      catch_phrase: "Innovative solutions for all your needs",
      bs: "Marketing"
    }
  end

  specify "root", :aggregate_failures do
    expect(perform).to be_a(Servactory::Result)
    expect(perform).to an_instance_of(Servactory::Result)

    expect(perform).to(
      have_attributes(
        id: id,
        first_name: first_name,
        last_name: last_name,
        email: email,
        birth_date: birth_date,
        addresses: be_present,
        phone: phone,
        website: website,
        company: be_present
      )
    )
  end

  specify "addresses", :aggregate_failures do
    expect(perform.addresses).to be_an(Array)

    expect(perform.addresses.first).to be_a(Servactory::Result)
    expect(perform.addresses.first).to an_instance_of(Servactory::Result)

    expect(perform.addresses.first).to(
      have_attributes(
        street: "123 Main Street",
        suite: "Apt. 4",
        city: "Anytown",
        zip_code: "12345-6789",
        geo: be_present
      )
    )

    expect(perform.addresses.first.geo).to be_a(Servactory::Result)
    expect(perform.addresses.first.geo).to an_instance_of(Servactory::Result)

    expect(perform.addresses.first.geo).to(
      have_attributes(
        latitude: "42.1234",
        longitude: "-71.2345"
      )
    )
  end

  specify "company", :aggregate_failures do
    expect(perform.company).to be_a(Servactory::Result)
    expect(perform.company).to an_instance_of(Servactory::Result)

    expect(perform.company).to(
      have_attributes(
        name: "ABC Company",
        catch_phrase: "Innovative solutions for all your needs",
        bs: "Marketing"
      )
    )
  end
end
