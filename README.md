<p align="center">
  <a href="https://rubygems.org/gems/datory"><img src="https://img.shields.io/gem/v/datory?logo=rubygems&logoColor=fff" alt="Gem version"></a>
  <a href="https://github.com/servactory/datory/releases"><img src="https://img.shields.io/github/release-date/servactory/datory" alt="Release Date"></a>
</p>

## Documentation

See [datory.servactory.com](https://datory.servactory.com) for documentation.

## Quick Start

### Installation

```ruby
gem "datory"
```

### Usage

#### Serialize

```ruby
serial = Serial.find(id)

SerialDto.serialize(serial) # => { ... }
```

#### Deserialize

```ruby
SerialDto.deserialize(json) # => Datory::Result
```

#### Form

For serialization, the `form` method is also available.
This prepares a `Form` object, which has a set of additional methods such as `valid?` and `invalid?`.

```ruby
form = SerialDto.form(serial)

form.target # => SerialDto
form.model # => { ... }

form.valid? # => true
form.invalid? # => false

form.serialize # => { ... }
```

#### Examples

```ruby
class SerialDto < Datory::Base
  uuid! :id

  string! :status
  string! :title

  one! :poster, include: ImageDto

  one! :ratings, include: RatingsDto

  many! :countries, include: CountryDto
  many! :genres, include: GenreDto
  many! :seasons, include: SeasonDto

  date! :premieredOn, to: :premiered_on
end
```

```ruby
class SeasonDto < Datory::Base
  uuid! :id
  uuid! :serialId, to: :serial_id

  integer! :number

  many! :episodes, include: EpisodeDto

  date! :premieredOn, to: :premiered_on
  date? :endedOn, to: :ended_on
end
```

## Attribute declaration

Using the `!` sign means that the attribute is required.
The optionality of an attribute is indicated using the `?` sign.

### Basic

#### attribute

```ruby
attribute :uuid, from: String, to: :id, as: String, format: :uuid
```

#### string!

```ruby
string! :uuid, to: :id
```

#### integer!

```ruby
integer! :rating, min: 1, max: 10
```

#### float!

```ruby
float! :rating
```

#### boolean!

```ruby
boolean! :default
```

### Helpers

#### uuid!

It will also check that the value matches the UUID format.

```ruby
uuid! :id
```

#### money!

It will prepare two attributes `*_cents` and `*_currency`.

```ruby
money! :box_office
```

#### duration!

```ruby
duration! :episode_duration
```

#### date!

```ruby
date! :premiered_on
```

#### time!

```ruby
time! :premiered_at
```

#### datetime!

```ruby
time! :premiered_at
```

### Nesting

#### one!

```ruby
one! :poster, include: ImageDto
```

#### many!

```ruby
many! :seasons, include: SeasonDto
```

## Object information

### Info

```ruby
SerialDto.info
```

```
#<Datory::Info::Result:0x0000000128a33c38 @attributes={:id=>{:from=>{:name=>:id, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:uuid}, :to=>{:name=>:id, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:uuid, :required=>true, :default=>nil, :include=>nil}}, :status=>{:from=>{:name=>:status, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:status, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :default=>nil, :include=>nil}}, :title=>{:from=>{:name=>:title, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:title, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :default=>nil, :include=>nil}}, :poster=>{:from=>{:name=>:poster, :type=>[Usual::Example1::Image, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:poster, :type=>[Usual::Example1::Image, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :default=>nil, :include=>Usual::Example1::Image}}, :ratings=>{:from=>{:name=>:ratings, :type=>[Usual::Example1::Ratings, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:ratings, :type=>[Usual::Example1::Ratings, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :default=>nil, :include=>Usual::Example1::Ratings}}, :countries=>{:from=>{:name=>:countries, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Country, Hash], :format=>nil}, :to=>{:name=>:countries, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Country, Hash], :format=>nil, :required=>true, :default=>nil, :include=>Usual::Example1::Country}}, :genres=>{:from=>{:name=>:genres, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Genre, Hash], :format=>nil}, :to=>{:name=>:genres, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Genre, Hash], :format=>nil, :required=>true, :default=>nil, :include=>Usual::Example1::Genre}}, :seasons=>{:from=>{:name=>:seasons, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Season, Hash], :format=>nil}, :to=>{:name=>:seasons, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Usual::Example1::Season, Hash], :format=>nil, :required=>true, :default=>nil, :include=>Usual::Example1::Season}}, :premieredOn=>{:from=>{:name=>:premieredOn, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:date}, :to=>{:name=>:premiered_on, :type=>Date, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :default=>nil, :include=>nil}}}>
```

### Describe

Alias: `table`

```ruby
SerialDto.describe
```

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                                         SerialDto                                         |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| Attribute   | From                         | To                 | As         | Include    |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| id          | String                       | id                 | String     |            |
| status      | String                       | status             | String     |            |
| title       | String                       | title              | String     |            |
| poster      | [ImageDto, Hash]   | poster  | [ImageDto, Hash]   | ImageDto   |            |
| ratings     | [RatingsDto, Hash] | ratings | [RatingsDto, Hash] | RatingsDto |            |
| countries   | Array                        | countries          | Array      | CountryDto |
| genres      | Array                        | genres             | Array      | GenreDto   |
| seasons     | Array                        | seasons            | Array      | SeasonDto  |
| premieredOn | String                       | premiered_on       | Date       |            |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

## Contributing

This project is intended to be a safe, welcoming space for collaboration. 
Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. 
We recommend reading the [contributing guide](./CONTRIBUTING.md) as well.

## License

Datory is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
