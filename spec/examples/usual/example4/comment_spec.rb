# frozen_string_literal: true

RSpec.describe Usual::Example4::Comment do
  describe "#form" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.form(comment) }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update(id: "2f391abd-de65-48ba-95b7-7c9746af70cf") }.to(
            change { perform.serialize.fetch(:id) }
              .from("f68a889c-0e2c-4f44-940b-cfb4aabea919")
              .to("2f391abd-de65-48ba-95b7-7c9746af70cf")
          )

          expect { perform.update(id: "a76fc8f3-4a4e-493d-9d7a-807b57f2bb34") }.to(
            change { perform.serialize.fetch(:id) }
              .from("2f391abd-de65-48ba-95b7-7c9746af70cf")
              .to("a76fc8f3-4a4e-493d-9d7a-807b57f2bb34")
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.form(comments) }

        let(:comments) { [comment] }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update_by(0, id: "2f391abd-de65-48ba-95b7-7c9746af70cf") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("f68a889c-0e2c-4f44-940b-cfb4aabea919")
              .to("2f391abd-de65-48ba-95b7-7c9746af70cf")
          )

          expect { perform.update_by(0, id: "a76fc8f3-4a4e-493d-9d7a-807b57f2bb34") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("2f391abd-de65-48ba-95b7-7c9746af70cf")
              .to("a76fc8f3-4a4e-493d-9d7a-807b57f2bb34")
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.form(comment) }

      it { expect(perform.valid?).to be(false) }

      it { expect { perform.serialize }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:comment) do
          Usual::Example4::Comment.to_model( # rubocop:disable RSpec/DescribedClass
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:comment) do
          Usual::Example4::Comment.to_model( # rubocop:disable RSpec/DescribedClass
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: 123 # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: 123 # THIS
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#serialize" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.serialize(comment) }

        it do
          expect(perform).to match(
            {
              id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
              parentId: nil,
              content: "Hello. This is my first comment here.",
              editedAt: nil,
              publishedAt: nil
            }
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.serialize(comments) }

        let(:comments) { [comment] }

        it do
          expect(perform).to contain_exactly(
            {
              id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
              parentId: nil,
              content: "Hello. This is my first comment here.",
              editedAt: nil,
              publishedAt: nil
            }
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.serialize(comment) }

      it { expect { perform }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:comment) do
          Usual::Example4::Comment.to_model( # rubocop:disable RSpec/DescribedClass
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:comment) do
          Usual::Example4::Comment.to_model( # rubocop:disable RSpec/DescribedClass
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: 123 # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:comment) do
        {
          id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
          content: "Hello. This is my first comment here."
        }
      end

      it_behaves_like "successful results"
    end
  end

  describe "#deserialize" do
    shared_examples "successful results" do
      subject(:perform) { described_class.deserialize(json) }

      describe "singular" do
        let(:json) { comment }

        specify "root", :aggregate_failures do
          expect(perform).to be_a(Servactory::Result)
          expect(perform).to an_instance_of(Datory::Result)

          expect(perform).to(
            have_attributes(
              id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
              content: "Hello. This is my first comment here."
            )
          )
        end
      end

      describe "plural" do
        let(:json) { [comment] }

        specify "root", :aggregate_failures do
          expect(perform).to be_an(Array)

          expect(perform).to all be_a(Servactory::Result)
          expect(perform).to all an_instance_of(Datory::Result)

          expect(perform).to(
            all(
              have_attributes(
                id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
                content: "Hello. This is my first comment here."
              )
            )
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.deserialize(comment) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "json" do
      context "when the data required for work is valid" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          }.to_json
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:comment) do
          {
            id: "f68a889c-0e2c-4f44-940b-cfb4aabea919",
            content: "Hello. This is my first comment here."
          }.to_json
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#describe" do
    describe "Usual::Example4::Comment" do
      subject(:perform) { Usual::Example4::Comment.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                        Usual::Example4::Comment                        |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From               | To           | As                   |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String             | id           | String               |
              | parentId    | [String, NilClass] | parent_id    | [String, NilClass]   |
              | content     | String             | content      | String               |
              | editedAt    | [String, NilClass] | edited_at    | [Time, NilClass]     |
              | publishedAt | [String, NilClass] | published_at | [DateTime, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#table" do
    describe "Usual::Example4::Comment" do
      subject(:perform) { Usual::Example4::Comment.table } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                        Usual::Example4::Comment                        |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From               | To           | As                   |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String             | id           | String               |
              | parentId    | [String, NilClass] | parent_id    | [String, NilClass]   |
              | content     | String             | content      | String               |
              | editedAt    | [String, NilClass] | edited_at    | [Time, NilClass]     |
              | publishedAt | [String, NilClass] | published_at | [DateTime, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#info" do
    describe "Usual::Example4::Comment" do
      subject(:perform) { Usual::Example4::Comment.info } # rubocop:disable RSpec/DescribedClass

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
              parentId: {
                from: {
                  consists_of: false,
                  format: :uuid,
                  max: nil,
                  min: nil,
                  name: :parentId,
                  type: [String, NilClass]
                },
                to: {
                  consists_of: false,
                  default: nil,
                  format: :uuid,
                  include: nil,
                  max: nil,
                  min: nil,
                  name: :parent_id,
                  required: false,
                  type: [String, NilClass]
                }
              },
              content: {
                from: {
                  consists_of: false,
                  format: nil,
                  max: nil,
                  min: nil,
                  name: :content,
                  type: String
                },
                to: {
                  consists_of: false,
                  default: nil,
                  format: nil,
                  include: nil,
                  max: nil,
                  min: nil,
                  name: :content,
                  required: true,
                  type: String
                }
              },
              editedAt: {
                from: {
                  consists_of: false,
                  format: :time,
                  max: nil,
                  min: nil,
                  name: :editedAt,
                  type: [String, NilClass]
                },
                to: {
                  consists_of: false,
                  default: nil,
                  format: nil,
                  include: nil,
                  max: nil,
                  min: nil,
                  name: :edited_at,
                  required: false,
                  type: [Time, NilClass]
                }
              },
              publishedAt: {
                from: {
                  consists_of: false,
                  format: :datetime,
                  max: nil,
                  min: nil,
                  name: :publishedAt,
                  type: [String, NilClass]
                },
                to: {
                  consists_of: false,
                  default: nil,
                  format: nil,
                  include: nil,
                  max: nil,
                  min: nil,
                  name: :published_at,
                  required: false,
                  type: [DateTime, NilClass]
                }
              }
            }
          )
        )
      end
    end
  end
end
