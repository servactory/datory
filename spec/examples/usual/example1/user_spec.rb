# frozen_string_literal: true

RSpec.describe Usual::Example1::User do
  describe "#serialize" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.serialize(user) }

        it do
          expect(perform).to match(
            {
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              firstname: "John",
              lastname: "Doe",
              email: "johndoe@example.com",
              birthDate: "1973-01-22",
              login: {
                id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
                username: "johndoe",
                password: "a25723600f7",
                md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
                sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
                lifetime: "P3M",
                registered_at: "2023-04-14T15:16:17+00:00"
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

      describe "plural" do
        subject(:perform) { described_class.serialize(users) }

        let(:users) { [user] }

        it do
          expect(perform).to contain_exactly(
            {
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              firstname: "John",
              lastname: "Doe",
              email: "johndoe@example.com",
              birthDate: "1973-01-22",
              login: {
                id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
                username: "johndoe",
                password: "a25723600f7",
                md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
                sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
                lifetime: "P3M",
                registered_at: "2023-04-14T15:16:17+00:00"
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
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.serialize(user) }

      it { expect { perform }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      let(:user) do
        Usual::Example1::User.to_model( # rubocop:disable RSpec/DescribedClass
          id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
          first_name: "John",
          last_name: "Doe",
          email: "johndoe@example.com",
          birth_date: Date.new(1973, 1, 22),
          login: login,
          addresses: addresses,
          phone: "(555) 555-1234",
          website: "www.johndoe.com",
          company: company,
          unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore."
        )
      end

      let(:login) do
        Usual::Example1::UserLogin.to_model(
          id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
          username: "johndoe",
          password: "a25723600f7",
          md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
          sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
          lifetime: 3.months,
          registered_at: DateTime.new(2023, 4, 14, 15, 16, 17)
        )
      end

      let(:addresses) do
        [
          Usual::Example1::UserAddress.to_model(
            street: "123 Main Street",
            suite: "Apt. 4",
            city: "Anytown",
            zip_code: "12345-6789",
            geo: Usual::Example1::UserAddressGeo.to_model(
              latitude: "42.1234",
              longitude: "-71.2345"
            )
          )
        ]
      end

      let(:company) do
        Usual::Example1::UserCompany.to_model(
          name: "ABC Company",
          catch_phrase: "Innovative solutions for all your needs",
          bs: "Marketing"
        )
      end

      context "when the data required for work is valid" do
        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:user) do
          Usual::Example1::User.to_model( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            first_name: "John",
            last_name: "Doe",
            email: "johndoe@example.com",
            birth_date: "1973-01-22", # THIS
            login: login,
            addresses: addresses,
            phone: "(555) 555-1234",
            website: "www.johndoe.com",
            company: company,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore."
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:user) do
        {
          id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
          first_name: "John",
          last_name: "Doe",
          email: "johndoe@example.com",
          birth_date: Date.new(1973, 1, 22),
          login: {
            id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
            username: "johndoe",
            password: "a25723600f7",
            md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
            sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
            lifetime: 3.months,
            registered_at: DateTime.new(2023, 4, 14, 15, 16, 17)
          },
          addresses: [
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
          ],
          phone: "(555) 555-1234",
          website: "www.johndoe.com",
          company: {
            name: "ABC Company",
            catch_phrase: "Innovative solutions for all your needs",
            bs: "Marketing"
          },
          unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore."
        }
      end

      it_behaves_like "successful results"
    end
  end

  describe "#deserialize" do
    shared_examples "successful results" do
      subject(:perform) { described_class.deserialize(json) }

      describe "singular" do
        let(:json) { user }

        specify "root", :aggregate_failures do
          expect(perform).to be_a(Servactory::Result)
          expect(perform).to an_instance_of(Datory::Result)

          expect(perform).to(
            have_attributes(
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              first_name: "John",
              last_name: "Doe",
              email: "johndoe@example.com",
              birth_date: Date.new(1973, 1, 22),
              login: be_present,
              addresses: be_present,
              phone: "(555) 555-1234",
              website: "www.johndoe.com",
              company: be_present
            )
          )
        end

        specify "login", :aggregate_failures do
          expect(perform.login).to be_a(Servactory::Result)
          expect(perform.login).to an_instance_of(Datory::Result)

          expect(perform.login).to(
            have_attributes(
              id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
              username: "johndoe",
              password: "a25723600f7",
              md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
              sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
              lifetime: 3.months,
              registered_at: DateTime.new(2023, 4, 14, 15, 16, 17)
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

      describe "plural" do
        let(:json) { [user] }

        specify "root", :aggregate_failures do
          expect(perform).to be_an(Array)

          expect(perform).to all be_a(Servactory::Result)
          expect(perform).to all an_instance_of(Datory::Result)

          expect(perform).to(
            all(
              have_attributes(
                id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
                first_name: "John",
                last_name: "Doe",
                email: "johndoe@example.com",
                birth_date: Date.new(1973, 1, 22),
                login: be_present,
                addresses: be_present,
                phone: "(555) 555-1234",
                website: "www.johndoe.com",
                company: be_present
              )
            )
          )
        end

        specify "login", :aggregate_failures do
          expect(perform.first.login).to be_a(Servactory::Result)
          expect(perform.first.login).to an_instance_of(Datory::Result)

          expect(perform.first.login).to(
            have_attributes(
              id: "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
              username: "johndoe",
              password: "a25723600f7",
              md5: "c1328472c5794a25723600f71c1b4586", # rubocop:disable Naming/VariableNumber
              sha1: "35544a31cc19bd6520af116554873167117f4d94", # rubocop:disable Naming/VariableNumber
              lifetime: 3.months,
              registered_at: DateTime.new(2023, 4, 14, 15, 16, 17)
            )
          )
        end

        specify "addresses", :aggregate_failures do
          expect(perform.first.addresses).to be_an(Array)

          expect(perform.first.addresses.first).to be_a(Servactory::Result)
          expect(perform.first.addresses.first).to an_instance_of(Datory::Result)

          expect(perform.first.addresses.first).to(
            have_attributes(
              street: "123 Main Street",
              suite: "Apt. 4",
              city: "Anytown",
              zip_code: "12345-6789",
              geo: be_present
            )
          )

          expect(perform.first.addresses.first.geo).to be_a(Servactory::Result)
          expect(perform.first.addresses.first.geo).to an_instance_of(Datory::Result)

          expect(perform.first.addresses.first.geo).to(
            have_attributes(
              latitude: "42.1234",
              longitude: "-71.2345"
            )
          )
        end

        specify "company", :aggregate_failures do
          expect(perform.first.company).to be_a(Servactory::Result)
          expect(perform.first.company).to an_instance_of(Datory::Result)

          expect(perform.first.company).to(
            have_attributes(
              name: "ABC Company",
              catch_phrase: "Innovative solutions for all your needs",
              bs: "Marketing"
            )
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.deserialize(user) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    # rubocop:disable Lint/SymbolConversion, Naming/VariableNumber
    let(:user) do
      {
        "id": "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
        "firstname": "John",
        "lastname": "Doe",
        "email": "johndoe@example.com",
        "birthDate": "1973-01-22",
        "login": {
          "id": "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
          "username": "johndoe",
          "password": "a25723600f7",
          "md5": "c1328472c5794a25723600f71c1b4586",
          "sha1": "35544a31cc19bd6520af116554873167117f4d94",
          "lifetime": "P3M",
          "registered_at": "2023-04-14T15:16:17+00:00"
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

    context "when the data required for work is valid" do
      it_behaves_like "successful results"
    end

    context "when the data required for work is invalid", skip: "Need to implement" do
      # rubocop:disable Lint/SymbolConversion, Naming/VariableNumber
      let(:user) do
        {
          "id": "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
          "firstname": "John",
          "lastname": "Doe",
          "email": "johndoe@example.com",
          "birthDate": Date.new(1973, 1, 22),
          "login": {
            "id": "1a0eed01-9430-4d68-901f-c0d4c1c3bf22",
            "username": "johndoe",
            "password": "a25723600f7",
            "md5": "c1328472c5794a25723600f71c1b4586",
            "sha1": "35544a31cc19bd6520af116554873167117f4d94",
            "lifetime": "P3M",
            "registered_at": "2023-04-14T15:16:17+00:00"
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

      it_behaves_like "unsuccessful results"
    end
  end

  describe "#describe" do
    describe "Usual::Example1::User" do
      subject(:perform) { Usual::Example1::User.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                  Usual::Example1::User                                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To         | As                     | Include                      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id        | String | id         | String                 |                              |
              | firstname | String | first_name | String                 |                              |
              | lastname  | String | last_name  | String                 |                              |
              | email     | String | email      | String                 |                              |
              | phone     | String | phone      | String                 |                              |
              | website   | String | website    | String                 |                              |
              | birthDate | String | birth_date | Date                   |                              |
              | login     | Hash   | login      | [Datory::Result, Hash] | Usual::Example1::UserLogin   |
              | company   | Hash   | company    | [Datory::Result, Hash] | Usual::Example1::UserCompany |
              | addresses | Array  | addresses  | Array                  | Usual::Example1::UserAddress |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::UserLogin" do
      subject(:perform) { Usual::Example1::UserLogin.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                    Usual::Example1::UserLogin                    |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute     | From   | To            | As                      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id            | String | id            | String                  |
              | username      | String | username      | String                  |
              | password      | String | password      | String                  |
              | md5           | String | md5           | String                  |
              | sha1          | String | sha1          | String                  |
              | lifetime      | String | lifetime      | ActiveSupport::Duration |
              | registered_at | String | registered_at | DateTime                |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::UserAddress" do
      subject(:perform) { Usual::Example1::UserAddress.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                               Usual::Example1::UserAddress                               |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To       | As                     | Include                         |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | street    | String | street   | String                 |                                 |
              | suite     | String | suite    | String                 |                                 |
              | city      | String | city     | String                 |                                 |
              | zipcode   | String | zip_code | String                 |                                 |
              | geo       | Hash   | geo      | [Datory::Result, Hash] | Usual::Example1::UserAddressGeo |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::UserCompany" do
      subject(:perform) { Usual::Example1::UserCompany.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |         Usual::Example1::UserCompany         |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From   | To           | As     |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | name        | String | name         | String |
              | catchPhrase | String | catch_phrase | String |
              | bs          | String | bs           | String |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#info" do
    describe "Usual::Example1::User" do
      subject(:perform) { Usual::Example1::User.info } # rubocop:disable RSpec/DescribedClass

      it :aggregate_failures do
        expect(perform).to be_instance_of(Datory::Info::Result)
        expect(perform.attributes).to(
          match(
            {
              id: {
                from: {
                  name: :id,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: :uuid
                },
                to: {
                  name: :id,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: :uuid,
                  include: nil
                }
              },
              firstname: {
                from: {
                  name: :firstname,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :first_name,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              lastname: {
                from: {
                  name: :lastname,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :last_name,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              email: {
                from: {
                  name: :email,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :email,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              phone: {
                from: {
                  name: :phone,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :phone,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil, include: nil
                }
              },
              website: {
                from: {
                  name: :website,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :website,
                  type: String,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              birthDate: {
                from: {
                  name: :birthDate,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: :date
                },
                to: {
                  name: :birth_date,
                  type: Date,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              login: {
                from: {
                  name: :login,
                  type: Hash,
                  min: nil, max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :login,
                  type: [Datory::Result, Hash],
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example1::UserLogin
                }
              },
              company: {
                from: {
                  name: :company,
                  type: Hash,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :company,
                  type: [Datory::Result, Hash],
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example1::UserCompany
                }
              },
              addresses: {
                from: {
                  name: :addresses,
                  type: Array,
                  min: nil,
                  max: nil,
                  consists_of: [Datory::Result, Hash],
                  format: nil
                },
                to: {
                  name: :addresses,
                  type: Array,
                  required: true,
                  min: nil,
                  max: nil,
                  consists_of: [Datory::Result, Hash],
                  format: nil,
                  include: Usual::Example1::UserAddress
                }
              }
            }
          )
        )
      end
    end
  end
end
