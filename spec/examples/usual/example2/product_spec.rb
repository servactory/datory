# frozen_string_literal: true

RSpec.describe Usual::Example2::Product do
  describe "#form" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.form(user) }

        it { expect(perform.valid?).to be(true) }

        it { expect(perform.serialize).to be_present }
      end

      describe "plural" do
        subject(:perform) { described_class.form(users) }

        let(:users) { [user] }

        it { expect(perform.valid?).to be(true) }

        it { expect(perform.serialize).to be_present }
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.form(user) }

      it { expect(perform.valid?).to be(false) }

      it { expect { perform.serialize }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:user) do
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
        let(:user) do
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
        let(:user) do
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
        let(:user) do
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
        subject(:perform) { described_class.serialize(user) }

        it do
          expect(perform).to match(
            {
              id: "55363a14-aa9a-4eba-9276-7f7cec432123",
              title: "iPhone 15 Pro",
              price_cents: 999_00,
              price_currency: "USD",
              quantity: 5
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
              id: "55363a14-aa9a-4eba-9276-7f7cec432123",
              title: "iPhone 15 Pro",
              price_cents: 999_00,
              price_currency: "USD",
              quantity: 5
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
      context "when the data required for work is valid" do
        let(:user) do
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
        let(:user) do
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
      let(:user) do
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
        let(:json) { user }

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
        let(:json) { [user] }

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
      subject(:perform) { described_class.deserialize(user) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    context "when the data required for work is valid" do
      # rubocop:disable Lint/SymbolConversion
      let(:user) do
        {
          "id": "55363a14-aa9a-4eba-9276-7f7cec432123",
          "title": "iPhone 15 Pro",
          "price_cents": 999_00,
          "price_currency": "USD",
          "quantity": 5
        }
      end
      # rubocop:enable Lint/SymbolConversion

      it_behaves_like "successful results"
    end

    context "when the data required for work is invalid", skip: "Need to implement" do
      # rubocop:disable Lint/SymbolConversion
      let(:user) do
        {
          "id": "55363a14-aa9a-4eba-9276-7f7cec432123",
          "title": "iPhone 15 Pro",
          "price_cents": "999.00",
          "price_currency": "USD",
          "quantity": 5
        }
      end
      # rubocop:enable Lint/SymbolConversion

      it_behaves_like "unsuccessful results"
    end
  end

  describe "#describe" do
    describe "Usual::Example2::Product" do
      subject(:perform) { Usual::Example2::Product.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                       Usual::Example2::Product                        |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute      | From             | To             | As               |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id             | String           | id             | String           |
              | title          | String           | title          | String           |
              | price_cents    | Integer          | price_cents    | Integer          |
              | price_currency | [Symbol, String] | price_currency | [Symbol, String] |
              | quantity       | Integer          | quantity       | Integer          |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
                  type: [Symbol, String],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :price_currency,
                  type: [Symbol, String],
                  required: true,
                  min: nil, max: nil,
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
                  min: 1,
                  max: 10,
                  consists_of: false,
                  format: nil,
                  include: nil
                }
              }
            }
          )
        )
      end
    end
  end
end
