# frozen_string_literal: true

RSpec.describe Usual::Example1::Serial do
  describe "#form" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.form(serial) }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update(id: "ed9bef42-9e17-4956-9c19-37c378349e6f") }.to(
            change { perform.serialize.fetch(:id) }
              .from("5eb3c7c2-2fbf-4266-9de9-36c6df823edd")
              .to("ed9bef42-9e17-4956-9c19-37c378349e6f")
          )

          expect { perform.update(id: "cef10b9c-a756-475d-ad68-cbf770bc6680") }.to(
            change { perform.serialize.fetch(:id) }
              .from("ed9bef42-9e17-4956-9c19-37c378349e6f")
              .to("cef10b9c-a756-475d-ad68-cbf770bc6680")
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.form(serials) }

        let(:serials) { [serial] }

        it { expect(perform.target).to eq(described_class) }
        it { expect(perform.model).to be_present }

        it { expect(perform.valid?).to be(true) }
        it { expect(perform.invalid?).to be(false) }

        it { expect(perform.serialize).to be_present }

        it :aggregate_failures do
          expect { perform.update_by(0, id: "ed9bef42-9e17-4956-9c19-37c378349e6f") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("5eb3c7c2-2fbf-4266-9de9-36c6df823edd")
              .to("ed9bef42-9e17-4956-9c19-37c378349e6f")
          )

          expect { perform.update_by(0, id: "cef10b9c-a756-475d-ad68-cbf770bc6680") }.to(
            change { perform.serialize[0].fetch(:id) }
              .from("ed9bef42-9e17-4956-9c19-37c378349e6f")
              .to("cef10b9c-a756-475d-ad68-cbf770bc6680")
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.form(serial) }

      it { expect(perform.valid?).to be(false) }

      it { expect { perform.serialize }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      let(:poster) do
        Usual::Example1::Image.new(
          url: "...",
          default: true
        )
      end

      let(:countries) do
        [
          Usual::Example1::Country.new(
            name: "United States",
            iso2: "us" # rubocop:disable Naming/VariableNumber
          )
        ]
      end

      let(:genres) do
        [
          Usual::Example1::Genre.new(
            name: "Crime",
            code: "crime"
          ),
          Usual::Example1::Genre.new(
            name: "Drama",
            code: "drama"
          ),
          Usual::Example1::Genre.new(
            name: "Thriller",
            code: "thriller"
          )
        ]
      end

      let(:seasons) do
        [
          Usual::Example1::Season.new(
            id: "27df8a44-556f-4e08-9984-4aa663b78f98",
            number: 1,
            premiered_on: Date.new(2008, 9, 3),
            ended_on: Date.new(2008, 11, 26)
          )
        ]
      end

      let(:ratings) do
        Usual::Example1::Ratings.new(
          imdb: Usual::Example1::Rating.new(
            value: 8.6,
            quantity: 324_000,
            link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
          )
        )
      end

      context "when the data required for work is valid" do
        let(:serial) do
          Usual::Example1::Serial.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: Date.new(2008, 9, 3)
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          Usual::Example1::Serial.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: "2008-09-03" # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:poster) do
        {
          url: "...",
          default: true
        }
      end

      let(:countries) do
        [
          {
            name: "United States",
            iso2: "us" # rubocop:disable Naming/VariableNumber
          }
        ]
      end

      let(:genres) do
        [
          {
            name: "Crime",
            code: "crime"
          },
          {
            name: "Drama",
            code: "drama"
          },
          {
            name: "Thriller",
            code: "thriller"
          }
        ]
      end

      let(:seasons) do
        [
          {
            id: "27df8a44-556f-4e08-9984-4aa663b78f98",
            number: 1,
            premiered_on: Date.new(2008, 9, 3),
            ended_on: Date.new(2008, 11, 26)
          }
        ]
      end

      let(:ratings) do
        Usual::Example1::Ratings.new(
          imdb: Usual::Example1::Rating.new(
            value: 8.6,
            quantity: 324_000,
            link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
          )
        )
      end

      context "when the data required for work is valid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: Date.new(2008, 9, 3)
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: "2008-09-03" # THIS
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#serialize" do
    shared_examples "successful results" do
      describe "singular" do
        subject(:perform) { described_class.serialize(serial) }

        it do
          expect(perform).to match(
            {
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              title: "Sons of Anarchy",
              status: "ended",
              poster: {
                url: "...",
                default: true
              },
              countries: [
                {
                  name: "United States",
                  iso2: "us" # rubocop:disable Naming/VariableNumber
                }
              ],
              genres: [
                {
                  name: "Crime",
                  code: "crime"
                },
                {
                  name: "Drama",
                  code: "drama"
                },
                {
                  name: "Thriller",
                  code: "thriller"
                }
              ],
              seasons: [
                {
                  id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                  number: 1,
                  premieredOn: "2008-09-03",
                  endedOn: "2008-11-26"
                }
              ],
              ratings: {
                imdb: {
                  value: 8.6,
                  quantity: 324_000,
                  linkUrl: nil
                }
              },
              premieredOn: "2008-09-03"
            }
          )
        end
      end

      describe "plural" do
        subject(:perform) { described_class.serialize(serials) }

        let(:serials) { [serial] }

        it do
          expect(perform).to contain_exactly(
            {
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              title: "Sons of Anarchy",
              status: "ended",
              poster: {
                url: "...",
                default: true
              },
              countries: [
                {
                  name: "United States",
                  iso2: "us" # rubocop:disable Naming/VariableNumber
                }
              ],
              genres: [
                {
                  name: "Crime",
                  code: "crime"
                },
                {
                  name: "Drama",
                  code: "drama"
                },
                {
                  name: "Thriller",
                  code: "thriller"
                }
              ],
              seasons: [
                {
                  id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                  number: 1,
                  premieredOn: "2008-09-03",
                  endedOn: "2008-11-26"
                }
              ],
              ratings: {
                imdb: {
                  value: 8.6,
                  quantity: 324_000,
                  linkUrl: nil
                }
              },
              premieredOn: "2008-09-03"
            }
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.serialize(serial) }

      it { expect { perform }.to raise_error(Datory::Exceptions::SerializationError) }
    end

    describe "objects" do
      let(:poster) do
        Usual::Example1::Image.new(
          url: "...",
          default: true
        )
      end

      let(:countries) do
        [
          Usual::Example1::Country.new(
            name: "United States",
            iso2: "us" # rubocop:disable Naming/VariableNumber
          )
        ]
      end

      let(:genres) do
        [
          Usual::Example1::Genre.new(
            name: "Crime",
            code: "crime"
          ),
          Usual::Example1::Genre.new(
            name: "Drama",
            code: "drama"
          ),
          Usual::Example1::Genre.new(
            name: "Thriller",
            code: "thriller"
          )
        ]
      end

      let(:seasons) do
        [
          Usual::Example1::Season.new(
            id: "27df8a44-556f-4e08-9984-4aa663b78f98",
            number: 1,
            premiered_on: Date.new(2008, 9, 3),
            ended_on: Date.new(2008, 11, 26)
          )
        ]
      end

      let(:ratings) do
        Usual::Example1::Ratings.new(
          imdb: Usual::Example1::Rating.new(
            value: 8.6,
            quantity: 324_000,
            link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
          )
        )
      end

      context "when the data required for work is valid" do
        let(:serial) do
          Usual::Example1::Serial.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: Date.new(2008, 9, 3)
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          Usual::Example1::Serial.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: "2008-09-03" # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      let(:poster) do
        {
          url: "...",
          default: true
        }
      end

      let(:countries) do
        [
          {
            name: "United States",
            iso2: "us" # rubocop:disable Naming/VariableNumber
          }
        ]
      end

      let(:genres) do
        [
          {
            name: "Crime",
            code: "crime"
          },
          {
            name: "Drama",
            code: "drama"
          },
          {
            name: "Thriller",
            code: "thriller"
          }
        ]
      end

      let(:seasons) do
        [
          {
            id: "27df8a44-556f-4e08-9984-4aa663b78f98",
            number: 1,
            premiered_on: Date.new(2008, 9, 3),
            ended_on: Date.new(2008, 11, 26)
          }
        ]
      end

      let(:ratings) do
        Usual::Example1::Ratings.new(
          imdb: Usual::Example1::Rating.new(
            value: 8.6,
            quantity: 324_000,
            link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
          )
        )
      end

      context "when the data required for work is valid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: Date.new(2008, 9, 3)
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unused_attribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premiered_on: "2008-09-03" # THIS
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#deserialize" do
    shared_examples "successful results" do
      subject(:perform) { described_class.deserialize(json) }

      describe "singular" do
        let(:json) { serial }

        specify "root", :aggregate_failures do
          expect(perform).to be_a(Usual::Example1::Serial) # rubocop:disable RSpec/DescribedClass
          expect(perform).to an_instance_of(Usual::Example1::Serial) # rubocop:disable RSpec/DescribedClass

          expect(perform).to(
            have_attributes(
              id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
              title: "Sons of Anarchy",
              status: "ended",
              poster: be_present,
              countries: be_present,
              genres: be_present,
              seasons: be_present,
              ratings: be_present,
              premiered_on: Date.new(2008, 9, 3)
            )
          )
        end

        specify "poster", :aggregate_failures do
          expect(perform.poster).to be_a(Usual::Example1::Image)
          expect(perform.poster).to an_instance_of(Usual::Example1::Image)

          expect(perform.poster).to(
            have_attributes(
              url: "...",
              default: true
            )
          )
        end

        specify "countries", :aggregate_failures do
          expect(perform.countries).to be_an(Array)

          expect(perform.countries).to all be_a(Usual::Example1::Country)
          expect(perform.countries).to all an_instance_of(Usual::Example1::Country)

          expect(perform.countries.first).to(
            have_attributes(
              name: "United States",
              iso2: "us" # rubocop:disable Naming/VariableNumber
            )
          )
        end

        specify "genres", :aggregate_failures do
          expect(perform.genres).to all be_a(Usual::Example1::Genre)
          expect(perform.genres).to all an_instance_of(Usual::Example1::Genre)

          expect(perform.genres.first).to(
            have_attributes(
              name: "Crime",
              code: "crime"
            )
          )

          expect(perform.genres.second).to(
            have_attributes(
              name: "Drama",
              code: "drama"
            )
          )

          expect(perform.genres.third).to(
            have_attributes(
              name: "Thriller",
              code: "thriller"
            )
          )
        end

        specify "seasons", :aggregate_failures do
          expect(perform.seasons).to all be_a(Usual::Example1::Season)
          expect(perform.seasons).to all an_instance_of(Usual::Example1::Season)

          expect(perform.seasons.first).to(
            have_attributes(
              id: "27df8a44-556f-4e08-9984-4aa663b78f98",
              number: 1,
              premiered_on: Date.new(2008, 9, 3),
              ended_on: Date.new(2008, 11, 26)
            )
          )
        end

        specify "ratings", :aggregate_failures do
          expect(perform.ratings).to be_a(Usual::Example1::Ratings)
          expect(perform.ratings).to an_instance_of(Usual::Example1::Ratings)

          expect(perform.ratings).to(
            have_attributes(
              imdb: have_attributes(
                value: 8.6,
                quantity: 324_000,
                link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
              )
            )
          )
        end
      end

      describe "plural" do
        let(:json) { [serial] }

        specify "root", :aggregate_failures do
          expect(perform).to be_an(Array)

          expect(perform).to all be_a(Usual::Example1::Serial) # rubocop:disable RSpec/DescribedClass
          expect(perform).to all an_instance_of(Usual::Example1::Serial) # rubocop:disable RSpec/DescribedClass

          expect(perform).to(
            all(
              have_attributes(
                id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
                title: "Sons of Anarchy",
                status: "ended",
                poster: be_present,
                countries: be_present,
                genres: be_present,
                seasons: be_present,
                ratings: be_present,
                premiered_on: Date.new(2008, 9, 3)
              )
            )
          )
        end

        specify "poster", :aggregate_failures do
          expect(perform.first.poster).to be_a(Usual::Example1::Image)
          expect(perform.first.poster).to an_instance_of(Usual::Example1::Image)

          expect(perform.first.poster).to(
            have_attributes(
              url: "...",
              default: true
            )
          )
        end

        specify "countries", :aggregate_failures do
          expect(perform.first.countries).to be_an(Array)

          expect(perform.first.countries).to all be_a(Usual::Example1::Country)
          expect(perform.first.countries).to all an_instance_of(Usual::Example1::Country)

          expect(perform.first.countries.first).to(
            have_attributes(
              name: "United States",
              iso2: "us" # rubocop:disable Naming/VariableNumber
            )
          )
        end

        specify "genres", :aggregate_failures do
          expect(perform.first.genres).to all be_a(Usual::Example1::Genre)
          expect(perform.first.genres).to all an_instance_of(Usual::Example1::Genre)

          expect(perform.first.genres.first).to(
            have_attributes(
              name: "Crime",
              code: "crime"
            )
          )

          expect(perform.first.genres.second).to(
            have_attributes(
              name: "Drama",
              code: "drama"
            )
          )

          expect(perform.first.genres.third).to(
            have_attributes(
              name: "Thriller",
              code: "thriller"
            )
          )
        end

        specify "seasons", :aggregate_failures do
          expect(perform.first.seasons).to all be_a(Usual::Example1::Season)
          expect(perform.first.seasons).to all an_instance_of(Usual::Example1::Season)

          expect(perform.first.seasons.first).to(
            have_attributes(
              id: "27df8a44-556f-4e08-9984-4aa663b78f98",
              number: 1,
              premiered_on: Date.new(2008, 9, 3),
              ended_on: Date.new(2008, 11, 26)
            )
          )
        end

        specify "ratings", :aggregate_failures do
          expect(perform.first.ratings).to be_a(Usual::Example1::Ratings)
          expect(perform.first.ratings).to an_instance_of(Usual::Example1::Ratings)

          expect(perform.first.ratings).to(
            have_attributes(
              imdb: have_attributes(
                value: 8.6,
                quantity: 324_000,
                link_url: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
              )
            )
          )
        end
      end
    end

    shared_examples "unsuccessful results" do
      subject(:perform) { described_class.deserialize(serial) }

      it { expect { perform }.to raise_error(Datory::Exceptions::DeserializationError) }
    end

    describe "objects" do
      let(:poster) do
        Usual::Example1::Image.deserialization.new(
          url: "...",
          default: true
        )
      end

      let(:countries) do
        [
          Usual::Example1::Country.deserialization.new(
            name: "United States",
            iso2: "us" # rubocop:disable Naming/VariableNumber
          )
        ]
      end

      let(:genres) do
        [
          Usual::Example1::Genre.deserialization.new(
            name: "Crime",
            code: "crime"
          ),
          Usual::Example1::Genre.deserialization.new(
            name: "Drama",
            code: "drama"
          ),
          Usual::Example1::Genre.deserialization.new(
            name: "Thriller",
            code: "thriller"
          )
        ]
      end

      let(:seasons) do
        [
          Usual::Example1::Season.deserialization.new(
            id: "27df8a44-556f-4e08-9984-4aa663b78f98",
            number: 1,
            premieredOn: "2008-09-03", # THIS
            endedOn: "2008-11-26"
          )
        ]
      end

      let(:ratings) do
        Usual::Example1::Ratings.deserialization.new(
          imdb: Usual::Example1::Rating.deserialization.new(
            value: 8.6,
            quantity: 324_000,
            linkUrl: nil # NOTE: This example explicitly passes the value `nil` for the optional attribute.
          )
        )
      end

      context "when the data required for work is valid" do
        let(:serial) do
          Usual::Example1::Serial.deserialization.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unusedAttribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premieredOn: "2008-09-03" # THIS
          )
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          Usual::Example1::Serial.deserialization.new( # rubocop:disable RSpec/DescribedClass
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: poster,
            countries: countries,
            genres: genres,
            seasons: seasons,
            ratings: ratings,
            unusedAttribute: "NOTE: This attribute is redundant. It tests success and ignore.",
            premieredOn: Date.new(2008, 9, 3) # THIS
          )
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "hash" do
      context "when the data required for work is valid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: {
              url: "...",
              default: true
            },
            countries: [
              {
                name: "United States",
                iso2: "us" # rubocop:disable Naming/VariableNumber
              }
            ],
            genres: [
              {
                name: "Crime",
                code: "crime"
              },
              {
                name: "Drama",
                code: "drama"
              },
              {
                name: "Thriller",
                code: "thriller"
              }
            ],
            seasons: [
              {
                id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                number: 1,
                premieredOn: "2008-09-03",
                endedOn: "2008-11-26"
              }
            ],
            ratings: {
              imdb: {
                value: 8.6,
                quantity: 324_000,
                linkUrl: nil
              }
            },
            premieredOn: "2008-09-03"
          }
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: {
              url: "...",
              default: true
            },
            countries: [
              {
                name: "United States",
                iso2: "us" # rubocop:disable Naming/VariableNumber
              }
            ],
            genres: [
              {
                name: "Crime",
                code: "crime"
              },
              {
                name: "Drama",
                code: "drama"
              },
              {
                name: "Thriller",
                code: "thriller"
              }
            ],
            seasons: [
              {
                id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                number: 1,
                premieredOn: "2008-09-03",
                endedOn: "2008-11-26"
              }
            ],
            ratings: {
              imdb: {
                value: 8.6,
                quantity: 324_000,
                linkUrl: nil
              }
            },
            premieredOn: DateTime.new(2023, 4, 14, 15, 16, 17)
          }
        end

        it_behaves_like "unsuccessful results"
      end
    end

    describe "json" do
      context "when the data required for work is valid" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: {
              url: "...",
              default: true
            },
            countries: [
              {
                name: "United States",
                iso2: "us" # rubocop:disable Naming/VariableNumber
              }
            ],
            genres: [
              {
                name: "Crime",
                code: "crime"
              },
              {
                name: "Drama",
                code: "drama"
              },
              {
                name: "Thriller",
                code: "thriller"
              }
            ],
            seasons: [
              {
                id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                number: 1,
                premieredOn: "2008-09-03",
                endedOn: "2008-11-26"
              }
            ],
            ratings: {
              imdb: {
                value: 8.6,
                quantity: 324_000,
                linkUrl: nil
              }
            },
            premieredOn: "2008-09-03"
          }.to_json
        end

        it_behaves_like "successful results"
      end

      context "when the data required for work is invalid", skip: "Need to implement" do
        let(:serial) do
          {
            id: "5eb3c7c2-2fbf-4266-9de9-36c6df823edd",
            title: "Sons of Anarchy",
            status: "ended",
            poster: {
              url: "...",
              default: true
            },
            countries: [
              {
                name: "United States",
                iso2: "us" # rubocop:disable Naming/VariableNumber
              }
            ],
            genres: [
              {
                name: "Crime",
                code: "crime"
              },
              {
                name: "Drama",
                code: "drama"
              },
              {
                name: "Thriller",
                code: "thriller"
              }
            ],
            seasons: [
              {
                id: "27df8a44-556f-4e08-9984-4aa663b78f98",
                number: 1,
                premieredOn: "2008-09-03",
                endedOn: "2008-11-26"
              }
            ],
            ratings: {
              imdb: {
                value: 8.6,
                quantity: 324_000,
                linkUrl: nil
              }
            },
            premieredOn: DateTime.new(2023, 4, 14, 15, 16, 17)
          }.to_json
        end

        it_behaves_like "unsuccessful results"
      end
    end
  end

  describe "#describe" do
    describe "Usual::Example1::Serial" do
      subject(:perform) { Usual::Example1::Serial.describe } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                                   Usual::Example1::Serial                                                   |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From                             | To           | As                               | Include                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String                           | id           | String                           |                          |
              | status      | String                           | status       | String                           |                          |
              | title       | String                           | title        | String                           |                          |
              | poster      | [Usual::Example1::Image, Hash]   | poster       | [Usual::Example1::Image, Hash]   | Usual::Example1::Image   |
              | ratings     | [Usual::Example1::Ratings, Hash] | ratings      | [Usual::Example1::Ratings, Hash] | Usual::Example1::Ratings |
              | countries   | Array                            | countries    | Array                            | Usual::Example1::Country |
              | genres      | Array                            | genres       | Array                            | Usual::Example1::Genre   |
              | seasons     | Array                            | seasons      | Array                            | Usual::Example1::Season  |
              | premieredOn | String                           | premiered_on | Date                             |                          |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Image" do
      subject(:perform) { Usual::Example1::Image.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                         Usual::Example1::Image                          |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From                    | To      | As                      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | url       | String                  | url     | String                  |
              | default   | [TrueClass, FalseClass] | default | [TrueClass, FalseClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Country" do
      subject(:perform) { Usual::Example1::Country.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |      Usual::Example1::Country      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To   | As     |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | name      | String | name | String |
              | iso2      | String | iso2 | String |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Genre" do
      subject(:perform) { Usual::Example1::Genre.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |       Usual::Example1::Genre       |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To   | As     |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | name      | String | name | String |
              | code      | String | code | String |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Season" do
      subject(:perform) { Usual::Example1::Season.describe }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                      Usual::Example1::Season                       |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From               | To           | As               |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String             | id           | String           |
              | number      | Integer            | number       | Integer          |
              | premieredOn | String             | premiered_on | Date             |
              | endedOn     | [String, NilClass] | ended_on     | [Date, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#table" do
    describe "Usual::Example1::Serial" do
      subject(:perform) { Usual::Example1::Serial.table } # rubocop:disable RSpec/DescribedClass

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                                                   Usual::Example1::Serial                                                   |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From                             | To           | As                               | Include                  |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String                           | id           | String                           |                          |
              | status      | String                           | status       | String                           |                          |
              | title       | String                           | title        | String                           |                          |
              | poster      | [Usual::Example1::Image, Hash]   | poster       | [Usual::Example1::Image, Hash]   | Usual::Example1::Image   |
              | ratings     | [Usual::Example1::Ratings, Hash] | ratings      | [Usual::Example1::Ratings, Hash] | Usual::Example1::Ratings |
              | countries   | Array                            | countries    | Array                            | Usual::Example1::Country |
              | genres      | Array                            | genres       | Array                            | Usual::Example1::Genre   |
              | seasons     | Array                            | seasons      | Array                            | Usual::Example1::Season  |
              | premieredOn | String                           | premiered_on | Date                             |                          |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Image" do
      subject(:perform) { Usual::Example1::Image.table }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                         Usual::Example1::Image                          |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From                    | To      | As                      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | url       | String                  | url     | String                  |
              | default   | [TrueClass, FalseClass] | default | [TrueClass, FalseClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Country" do
      subject(:perform) { Usual::Example1::Country.table }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |      Usual::Example1::Country      |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To   | As     |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | name      | String | name | String |
              | iso2      | String | iso2 | String |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Genre" do
      subject(:perform) { Usual::Example1::Genre.table }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |       Usual::Example1::Genre       |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute | From   | To   | As     |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | name      | String | name | String |
              | code      | String | code | String |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end

    describe "Usual::Example1::Season" do
      subject(:perform) { Usual::Example1::Season.table }

      it do
        expect { perform }.to(
          output(
            <<~TABLE
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              |                      Usual::Example1::Season                       |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | Attribute   | From               | To           | As               |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
              | id          | String             | id           | String           |
              | number      | Integer            | number       | Integer          |
              | premieredOn | String             | premiered_on | Date             |
              | endedOn     | [String, NilClass] | ended_on     | [Date, NilClass] |
              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            TABLE
          ).to_stdout
        )
      end
    end
  end

  describe "#info" do
    describe "Usual::Example1::User" do
      subject(:perform) { Usual::Example1::Serial.info } # rubocop:disable RSpec/DescribedClass

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
              status: {
                from: {
                  name: :status,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :status,
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
              poster: {
                from: {
                  name: :poster,
                  type: [Usual::Example1::Image, Hash],
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil
                },
                to: {
                  name: :poster,
                  type: [Usual::Example1::Image, Hash],
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example1::Image
                }
              },
              ratings: {
                from: {
                  consists_of: false,
                  format: nil,
                  max: nil,
                  min: nil,
                  name: :ratings,
                  type: [Usual::Example1::Ratings, Hash]
                },
                to: {
                  name: :ratings,
                  type: [Usual::Example1::Ratings, Hash],
                  required: true,
                  default: nil,
                  consists_of: false,
                  format: nil,
                  include: Usual::Example1::Ratings,
                  max: nil,
                  min: nil
                }
              },
              countries: {
                from: {
                  name: :countries,
                  type: Array,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Country, Hash],
                  format: nil
                },
                to: {
                  name: :countries,
                  type: Array,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Country, Hash],
                  format: nil,
                  include: Usual::Example1::Country
                }
              },
              genres: {
                from: {
                  name: :genres,
                  type: Array,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Genre, Hash],
                  format: nil
                },
                to: {
                  name: :genres,
                  type: Array,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Genre, Hash],
                  format: nil,
                  include: Usual::Example1::Genre
                }
              },
              seasons: {
                from: {
                  name: :seasons,
                  type: Array,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Season, Hash],
                  format: nil
                },
                to: {
                  name: :seasons,
                  type: Array,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
                  consists_of: [Usual::Example1::Season, Hash],
                  format: nil,
                  include: Usual::Example1::Season
                }
              },
              premieredOn: {
                from: {
                  name: :premieredOn,
                  type: String,
                  min: nil,
                  max: nil,
                  consists_of: false,
                  format: :date
                },
                to: {
                  name: :premiered_on,
                  type: Date,
                  required: true,
                  default: nil,
                  min: nil,
                  max: nil,
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
