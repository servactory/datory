# frozen_string_literal: true

RSpec.describe Usual::Example1::User do
  describe "#serialize" do
    subject(:perform) { described_class.serialize(user) }

    let(:user) do
      described_class::ARModel.new(
        first_name: "John",
        last_name: "Doe",
        email: "johndoe@example.com",
        birth_date: "1973-01-22",
        login: login,
        addresses: addresses,
        phone: "(555) 555-1234",
        website: "www.johndoe.com",
        company: company
      )
    end

    let(:login) do
      Usual::Example1::UserLogin::ARModel.new(
        uuid: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
        username: "johndoe",
        password: "a25723600f7",
        md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
        sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
        registered: "2023-01-10T10:03:20.022Z"
      )
    end

    let(:addresses) do
      [
        Usual::Example1::UserAddress::ARModel.new(
          street: "123 Main Street",
          suite: "Apt. 4",
          city: "Anytown",
          zip_code: "12345-6789",
          geo: Usual::Example1::UserAddressGeo::ARModel.new(
            latitude: "42.1234",
            longitude: "-71.2345"
          )
        )
      ]
    end

    let(:company) do
      Usual::Example1::UserCompany::ARModel.new(
        name: "ABC Company",
        catch_phrase: "Innovative solutions for all your needs",
        bs: "Marketing"
      )
    end

    it do
      expect(perform).to match(
        {
          id: be_present,
          firstname: "John",
          lastname: "Doe",
          email: "johndoe@example.com",
          birthDate: "1973-01-22",
          login: {
            uuid: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
            username: "johndoe",
            password: "a25723600f7",
            md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
            sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
            registered: "2023-01-10T10:03:20.022Z"
          },
          addresses: [
            {
              street: "123 Main Street",
              suite: "Apt. 4",
              city: "Anytown",
              zipcode: "12345-6789",
              geo: {
                lat: "42.1234",
                lng: "-71.2345"
              }
            }
          ],
          phone: "(555) 555-1234",
          website: "www.johndoe.com",
          company: {
            name: "ABC Company",
            catchPhrase: "Innovative solutions for all your needs",
            bs: "Marketing"
          }
        }
      )
    end
  end

  describe "#deserialize" do
    subject(:perform) { described_class.deserialize(json) }

    # rubocop:disable Lint/SymbolConversion, Naming/VariableNumber
    let(:json) do
      {
        "id": "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
        "firstname": "John",
        "lastname": "Doe",
        "email": "johndoe@example.com",
        "birthDate": "1973-01-22",
        "login": {
          "uuid": "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
          "username": "johndoe",
          "password": "a25723600f7",
          "md5": "c1328472c5794a25723600f71c1b4586",
          "sha1": "35544a31cc19bd6520af116554873167117f4d94",
          "registered": "2023-01-10T10:03:20.022Z"
        },
        "addresses": [
          {
            "street": "123 Main Street",
            "suite": "Apt. 4",
            "city": "Anytown",
            "zipcode": "12345-6789",
            "geo": {
              "lat": "42.1234",
              "lng": "-71.2345"
            }
          }
        ],
        "phone": "(555) 555-1234",
        "website": "www.johndoe.com",
        "company": {
          "name": "ABC Company",
          "catchPhrase": "Innovative solutions for all your needs",
          "bs": "Marketing"
        }
      }
    end
    # rubocop:enable Lint/SymbolConversion, Naming/VariableNumber

    specify "root", :aggregate_failures do
      expect(perform).to be_a(Servactory::Result)
      expect(perform).to an_instance_of(Datory::Result)

      expect(perform).to(
        have_attributes(
          id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
          first_name: "John",
          last_name: "Doe",
          email: "johndoe@example.com",
          birth_date: "1973-01-22",
          login: be_present,
          addresses: be_present,
          phone: "(555) 555-1234",
          website: "www.johndoe.com",
          company: be_present
        )
      )
    end

    specify "addresses", :aggregate_failures do
      expect(perform.addresses).to be_an(Array)

      expect(perform.addresses.first).to be_a(Servactory::Result)
      expect(perform.addresses.first).to an_instance_of(Datory::Result)

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
      expect(perform.addresses.first.geo).to an_instance_of(Datory::Result)

      expect(perform.addresses.first.geo).to(
        have_attributes(
          latitude: "42.1234",
          longitude: "-71.2345"
        )
      )
    end

    specify "company", :aggregate_failures do
      expect(perform.company).to be_a(Servactory::Result)
      expect(perform.company).to an_instance_of(Datory::Result)

      expect(perform.company).to(
        have_attributes(
          name: "ABC Company",
          catch_phrase: "Innovative solutions for all your needs",
          bs: "Marketing"
        )
      )
    end
  end

  describe "#build" do
    subject(:perform) { described_class.build(**attributes) }

    let(:attributes) do
      {
        id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
        firstname: "John",
        lastname: "Doe",
        email: "johndoe@example.com",
        birthDate: "1973-01-22",
        login: {
          uuid: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
          username: "johndoe",
          password: "a25723600f7",
          md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
          sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
          registered: "2023-01-10T10:03:20.022Z"
        },
        addresses: [
          {
            street: "123 Main Street",
            suite: "Apt. 4",
            city: "Anytown",
            zipcode: "12345-6789",
            geo: {
              lat: "42.1234",
              lng: "-71.2345"
            }
          }
        ],
        phone: "(555) 555-1234",
        website: "www.johndoe.com",
        company: {
          name: "ABC Company",
          catchPhrase: "Innovative solutions for all your needs",
          bs: "Marketing"
        }
      }
    end

    specify "root", :aggregate_failures do
      expect(perform).to be_a(Servactory::Result)
      expect(perform).to an_instance_of(Datory::Result)

      expect(perform).to(
        have_attributes(
          id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
          first_name: "John",
          last_name: "Doe",
          email: "johndoe@example.com",
          birth_date: "1973-01-22",
          login: be_present,
          addresses: be_present,
          phone: "(555) 555-1234",
          website: "www.johndoe.com",
          company: be_present
        )
      )
    end

    specify "addresses", :aggregate_failures do
      expect(perform.addresses).to be_an(Array)

      expect(perform.addresses.first).to be_a(Servactory::Result)
      expect(perform.addresses.first).to an_instance_of(Datory::Result)

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
      expect(perform.addresses.first.geo).to an_instance_of(Datory::Result)

      expect(perform.addresses.first.geo).to(
        have_attributes(
          latitude: "42.1234",
          longitude: "-71.2345"
        )
      )
    end

    specify "company", :aggregate_failures do
      expect(perform.company).to be_a(Servactory::Result)
      expect(perform.company).to an_instance_of(Datory::Result)

      expect(perform.company).to(
        have_attributes(
          name: "ABC Company",
          catch_phrase: "Innovative solutions for all your needs",
          bs: "Marketing"
        )
      )
    end
  end
end
