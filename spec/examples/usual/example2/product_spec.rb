# frozen_string_literal: true

RSpec.describe Usual::Example2::Product do
  describe "#form" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.form(product) }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update(id: "5baebc74-f680-4598-b077-7a5c13dd1543") }.to(
            change { perform.serialize.fetch(:id) }
              .from("55363a14-aa9a-4eba-9276-7f7cec432123")
              .to("5baebc74-f680-4598-b077-7a5c13dd1543")
          )

          expect { perform.update(id: "a88e0182-e0c9-466a-9816-7321699de97b") }.to(
            change { perform.serialize.fetch(:id) }
              .from("5baebc74-f680-4598-b077-7a5c13dd1543")
              .to("a88e0182-e0c9-466a-9816-7321699de97b")
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.form(products) }

        let(:products) { [product] }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update_by(0, id: "5baebc74-f680-4598-b077-7a5c13dd1543") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("55363a14-aa9a-4eba-9276-7f7cec432123")
              .to("5baebc74-f680-4598-b077-7a5c13dd1543")
          )

          expect { perform.update_by(0, id: "a88e0182-e0c9-466a-9816-7321699de97b") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("5baebc74-f680-4598-b077-7a5c13dd1543")
              .to("a88e0182-e0c9-466a-9816-7321699de97b")
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.form(product) }

      it { expect(perform.valid?).to be(false) }

      it { expect { perform.serialize }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:product) do
          Usual::Example2::Product.to_model( # rubocop:disable RSpec/DescribedClass
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: 999_00,
            price_currency: "USD",
            quantity: 5
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:product) do
          Usual::Example2::Product.to_model( # rubocop:disable RSpec/DescribedClass
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: "999.00",
            price_currency: "USD",
            quantity: 5
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: 999_00,
            price_currency: "USD",
            quantity: 5
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: "999.00",
            price_currency: "USD",
            quantity: 5
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#serialize" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.serialize(product) }

        it do
          expect(perform).to match(
            {
              id: "55363a14-aa9a-4eba-9276-7f7cec432123",
              title: "iPhone 15 Pro",
              price_cents: 999_00,
              price_currency: "USD",
              discount_cents: nil,
              discount_currency: nil,
              quantity: 5,
              installmentDuration: nil
            }
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.serialize(products) }

        let(:products) { [product] }

        it do
          expect(perform).to contain_exactly(
            {
              id: "55363a14-aa9a-4eba-9276-7f7cec432123",
              title: "iPhone 15 Pro",
              price_cents: 999_00,
              price_currency: "USD",
              discount_cents: nil,
              discount_currency: nil,
              quantity: 5,
              installmentDuration: nil
            }
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.serialize(product) }

      it { expect { perform }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:product) do
          Usual::Example2::Product.to_model( # rubocop:disable RSpec/DescribedClass
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: 999_00,
            price_currency: "USD",
            quantity: 5
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:product) do
          Usual::Example2::Product.to_model( # rubocop:disable RSpec/DescribedClass
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: "999.00",
            price_currency: "USD",
            quantity: 5
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:product) do
        {
          id: "55363a14-aa9a-4eba-9276-7f7cec432123",
          title: "iPhone 15 Pro",
          price_cents: 999_00,
          price_currency: "USD",
          quantity: 5
        }
      end

      it_behaves_like "successful results"
    end
  end

  describe "#deserialize" do
    shared_examples "successful results" do
      subject(:perform) { described_class.deserialize(json) }

      describe "singular" do
        let(:json) { product }

        specify "root", :aggregate_failures do
          expect(perform).to be_a(Servactory::Result)
          expect(perform).to an_instance_of(Datory::Result)

          expect(perform).to(
            have_attributes(
              id: "55363a14-aa9a-4eba-9276-7f7cec432123",
              title: "iPhone 15 Pro",
              price_cents: 999_00,
              price_currency: "USD",
              quantity: 5
            )
          )
        end
      end

      describe "plural" do
        let(:json) { [product] }

        specify "root", :aggregate_failures do
          expect(perform).to be_an(Array)

          expect(perform).to all be_a(Servactory::Result)
          expect(perform).to all an_instance_of(Datory::Result)

          expect(perform).to(
            all(
              have_attributes(
                id: "55363a14-aa9a-4eba-9276-7f7cec432123",
                title: "iPhone 15 Pro",
                price_cents: 999_00,
                price_currency: "USD",
                quantity: 5
              )
            )
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.deserialize(product) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: 999_00,
            price_currency: "USD",
            quantity: 5
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: "999.00",
            price_currency: "USD",
            quantity: 5
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "json" do
      context "when the data required for work is valid" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: 999_00,
            price_currency: "USD",
            quantity: 5
          }.to_json
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:product) do
          {
            id: "55363a14-aa9a-4eba-9276-7f7cec432123",
            title: "iPhone 15 Pro",
            price_cents: "999.00",
            price_currency: "USD",
            quantity: 5
          }.to_json
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#describe" do
    describe "Usual::Example2::Product" do
      subject(:perform) { Usual::Example2::Product.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                        Usual::Example2::Product                                        |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute           | From                | To                   | As                                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id                  | String              | id                   | String                              |
              | title               | String              | title                | String                              |
              | price_cents         | Integer             | price_cents          | Integer                             |
              | price_currency      | String              | price_currency       | String                              |
              | discount_cents      | [Integer, NilClass] | discount_cents       | [Integer, NilClass]                 |
              | discount_currency   | [String, NilClass]  | discount_currency    | [String, NilClass]                  |
              | quantity            | Integer             | quantity             | Integer                             |
              | installmentDuration | [String, NilClass]  | installment_duration | [ActiveSupport::Duration, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#table" do
    describe "Usual::Example2::Product" do
      subject(:perform) { Usual::Example2::Product.table } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                        Usual::Example2::Product                                        |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute           | From                | To                   | As                                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id                  | String              | id                   | String                              |
              | title               | String              | title                | String                              |
              | price_cents         | Integer             | price_cents          | Integer                             |
              | price_currency      | String              | price_currency       | String                              |
              | discount_cents      | [Integer, NilClass] | discount_cents       | [Integer, NilClass]                 |
              | discount_currency   | [String, NilClass]  | discount_currency    | [String, NilClass]                  |
              | quantity            | Integer             | quantity             | Integer                             |
              | installmentDuration | [String, NilClass]  | installment_duration | [ActiveSupport::Duration, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#info" do
    describe "Usual::Example2::Product" do
      subject(:perform) { Usual::Example2::Product.info } # rubocop:disable RSpec/DescribedClass

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
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: :uuid,
                  include: nil
                }
              },
              title: {
                from: {
                  name: :title,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :title,
                  type: String,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              price_cents: {
                from: {
                  name: :price_cents,
                  type: Integer,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :price_cents,
                  type: Integer,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              price_currency: {
                from: {
                  name: :price_currency,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :price_currency,
                  type: String,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              discount_cents: {
                from: {
                  name: :discount_cents,
                  type: [Integer, NilClass],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :discount_cents,
                  type: [Integer, NilClass],
                  required: false,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              discount_currency: {
                from: {
                  name: :discount_currency,
                  type: [String, NilClass],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :discount_currency,
                  type: [String, NilClass],
                  required: false,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              quantity: {
                from: {
                  name: :quantity,
                  type: Integer,
                  min: 1,
                  max: 10,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :quantity,
                  type: Integer,
                  required: true,
                  default: nil,
                  min: 1,
                  max: 10,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              },
              installmentDuration: {
                from: {
                  consists_of: false,
                  format: :duration,
                  max: nil,
                  min: nil,
                  name: :installmentDuration,
                  type: [String, NilClass]
                },
                to: {
                  consists_of: false,
                  default: nil,
                  format: nil,
                  include: nil,
                  max: nil,
                  min: nil,
                  name: :installment_duration,
                  required: false,
                  type: [ActiveSupport::Duration, NilClass]
                }
              }
            }
          )
        )
      end
    end
  end
end
