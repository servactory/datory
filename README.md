<p align="center">
  <a href="https://rubygems.org/gems/datory"><img src="https://img.shields.io/gem/v/datory?logo=rubygems&logoColor=fff" alt="Gem version"></a>
  <a href="https://github.com/servactory/datory/releases"><img src="https://img.shields.io/github/release-date/servactory/datory" alt="Release Date"></a>
</p>

## Documentation (soon)

See [datory.servactory.com](https://datory.servactory.com) for documentation.

## Quick Start

### Installation

```ruby
gem "datory"
```

### Usage

#### Serialize

```ruby
user = User.find(...)

UserDto.serialize(user)
```

#### Deserialize

```ruby
UserDto.deserialize(json)
```

#### Examples

```ruby
class UserDto < Datory::Base
  string :id
  string :firstname, to: :first_name
  string :lastname, to: :last_name
  string :email
  string :birthDate, to: :birth_date, output: ->(value:) { value.to_s }

  one :login, include: UserLoginDto

  many :addresses, include: UserAddressDto

  string :phone
  string :website

  one :company, include: UserCompanyDto
end
```

```ruby
class UserLoginDto < Datory::Base
  string :uuid
  string :username
  string :password
  string :md5
  string :sha1
  string :registered
end
```

## Contributing

This project is intended to be a safe, welcoming space for collaboration. 
Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. 
We recommend reading the [contributing guide](./website/docs/CONTRIBUTING.md) as well.

## License

Datory is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
