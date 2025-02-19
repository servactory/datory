# frozen_string_literal: true

RSpec.describe Usual::Example3::Language do
  describe "#form" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.form(language) }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update(id: "b04b96fd-5c39-4677-98bb-0f82edcf7f14") }.to(
            change { perform.serialize.fetch(:id) }
              .from("73031620-be3b-4088-9a78-5589ff7e1f61")
              .to("b04b96fd-5c39-4677-98bb-0f82edcf7f14")
          )

          expect { perform.update(id: "181dc995-e6da-43ee-b082-c9968cdcdd74") }.to(
            change { perform.serialize.fetch(:id) }
              .from("b04b96fd-5c39-4677-98bb-0f82edcf7f14")
              .to("181dc995-e6da-43ee-b082-c9968cdcdd74")
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.form(languages) }

        let(:languages) { [language] }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update_by(0, id: "b04b96fd-5c39-4677-98bb-0f82edcf7f14") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("73031620-be3b-4088-9a78-5589ff7e1f61")
              .to("b04b96fd-5c39-4677-98bb-0f82edcf7f14")
          )

          expect { perform.update_by(0, id: "181dc995-e6da-43ee-b082-c9968cdcdd74") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("b04b96fd-5c39-4677-98bb-0f82edcf7f14")
              .to("181dc995-e6da-43ee-b082-c9968cdcdd74")
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.form(language) }

      it { expect(perform.valid?).to be(false) }

      it { expect { perform.serialize }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:language) do
          Usual::Example3::Language.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            current: current_version
          )
        end

        let(:current_version) do
          Usual::Example3::Version.new(
            name: "3.4.2"
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:language) do
          Usual::Example3::Language.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: 123 # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            current: {
              name: "3.4.2"
            }
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: 123 # THIS
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#serialize" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.serialize(language) }

        it { expect { perform }.not_to(change { language }) }

        it do
          expect(perform).to match(
            {
              id: "73031620-be3b-4088-9a78-5589ff7e1f61",
              name: "Ruby",
              currentVersion: {
                name: "3.4.2",
                releasedAt: nil,
                endedAt: nil
              },
              lastEOLVersion: nil,
              previousVersions: []
            }
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.serialize(languages) }

        let(:languages) { [language] }

        it { expect { perform }.not_to(change { languages }) }

        it do
          expect(perform).to contain_exactly(
            {
              id: "73031620-be3b-4088-9a78-5589ff7e1f61",
              name: "Ruby",
              currentVersion: {
                name: "3.4.2",
                releasedAt: nil,
                endedAt: nil
              },
              lastEOLVersion: nil,
              previousVersions: []
            }
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.serialize(language) }

      it { expect { perform }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:language) do
          Usual::Example3::Language.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            current: current_version
          )
        end

        let(:current_version) do
          Usual::Example3::Version.new(
            name: "3.4.2"
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:language) do
          Usual::Example3::Language.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: 123 # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:language) do
        {
          id: "73031620-be3b-4088-9a78-5589ff7e1f61",
          name: "Ruby",
          current: current_version
        }
      end

      let(:current_version) do
        {
          name: "3.4.2"
        }
      end

      it_behaves_like "successful results"
    end
  end

  describe "#deserialize" do
    shared_examples "successful results" do
      subject(:perform) { described_class.deserialize(json) }

      describe "singular" do
        let(:json) { language }

        specify "root", :aggregate_failures do
          expect(perform).to be_a(Usual::Example3::Language) # rubocop:disable RSpec/DescribedClass
          expect(perform).to an_instance_of(Usual::Example3::Language) # rubocop:disable RSpec/DescribedClass

          expect(perform).to(
            have_attributes(
              id: "73031620-be3b-4088-9a78-5589ff7e1f61",
              name: "Ruby"
            )
          )
        end
      end

      describe "plural" do
        let(:json) { [language] }

        specify "root", :aggregate_failures do
          expect(perform).to be_an(Array)

          expect(perform).to all be_a(Usual::Example3::Language) # rubocop:disable RSpec/DescribedClass
          expect(perform).to all an_instance_of(Usual::Example3::Language) # rubocop:disable RSpec/DescribedClass

          expect(perform).to(
            all(
              have_attributes(
                id: "73031620-be3b-4088-9a78-5589ff7e1f61",
                name: "Ruby"
              )
            )
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.deserialize(language) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    describe "objects" do
      context "when the data required for work is valid" do
        let(:language) do
          Usual::Example3::Language.deserialization.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            currentVersion: current_version
          )
        end

        let(:current_version) do
          Usual::Example3::Version.deserialization.new(
            name: "3.4.2"
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:language) do
          Usual::Example3::Language.deserialization.new( # rubocop:disable RSpec/DescribedClass
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: 123 # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            currentVersion: {
              name: "3.4.2"
            }
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby"
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "json" do
      context "when the data required for work is valid" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            currentVersion: {
              name: "3.4.2"
            }
          }.to_json
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:language) do
          {
            id: "73031620-be3b-4088-9a78-5589ff7e1f61",
            name: "Ruby",
            currentVersion: {
              name: "3.4.2"
            }
          }.to_json
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#describe" do
    describe "Usual::Example3::Language" do
      subject(:perform) { Usual::Example3::Language.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                                            Usual::Example3::Language                                                             |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute        | From                                       | To       | As                                         | Include                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id               | String                                     | id       | String                                     |                          |
              | name             | String                                     | name     | String                                     |                          |
              | currentVersion   | [Usual::Example3::Version, Hash]           | current  | [Usual::Example3::Version, Hash]           | Usual::Example3::Version |
              | lastEOLVersion   | [Usual::Example3::Version, Hash, NilClass] | last_eol | [Usual::Example3::Version, Hash, NilClass] | Usual::Example3::Version |
              | previousVersions | Array                                      | previous | Array                                      | Usual::Example3::Version |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#table" do
    describe "Usual::Example3::Language" do
      subject(:perform) { Usual::Example3::Language.table } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                                            Usual::Example3::Language                                                             |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute        | From                                       | To       | As                                         | Include                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id               | String                                     | id       | String                                     |                          |
              | name             | String                                     | name     | String                                     |                          |
              | currentVersion   | [Usual::Example3::Version, Hash]           | current  | [Usual::Example3::Version, Hash]           | Usual::Example3::Version |
              | lastEOLVersion   | [Usual::Example3::Version, Hash, NilClass] | last_eol | [Usual::Example3::Version, Hash, NilClass] | Usual::Example3::Version |
              | previousVersions | Array                                      | previous | Array                                      | Usual::Example3::Version |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#info" do
    describe "Usual::Example3::Language" do
      subject(:perform) { Usual::Example3::Language.info } # rubocop:disable RSpec/DescribedClass

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
              name: {
                from: {
                  name: :name,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :name,
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
              currentVersion: {
                from: {
                  name: :currentVersion,
                  type: [Usual::Example3::Version, Hash],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :current,
                  type: [Usual::Example3::Version, Hash],
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example3::Version
                }
              },
              lastEOLVersion: {
                from: {
                  name: :lastEOLVersion,
                  type: [Usual::Example3::Version, Hash, NilClass],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :last_eol,
                  type: [Usual::Example3::Version, Hash, NilClass],
                  required: false,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example3::Version
                }
              },
              previousVersions: {
                from: {
                  name: :previousVersions,
                  type: Array,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example3::Version, Hash],
                  format: nil
                },
                to: {
                  name: :previous,
                  type: Array,
                  required: false,
                  default: [],
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example3::Version, Hash],
                  format: nil,
                  include: Usual::Example3::Version
                }
              }
            }
          )
        )
      end
    end
  end
end
