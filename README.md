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
  uuid :id

  string :firstname, to: :first_name
  string :lastname, to: :last_name

  string :email
  string :phone
  string :website

  string :birthDate, to: :birth_date, as: Date

  one :login, include: UserLoginDto
  one :company, include: UserCompanyDto

  many :addresses, include: UserAddressDto
end
```

```ruby
class UserLoginDto < Datory::Base
  uuid :id
  
  string :username
  string :password
  
  string :md5
  string :sha1
  
  string :registered_at, as: DateTime
end
```

### Object information

```ruby
UserDto.describe
```

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                         UserDto                          |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| Attribute | From   | To         | As                     |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| id        | String | id         | String                 |
| firstname | String | first_name | String                 |
| lastname  | String | last_name  | String                 |
| email     | String | email      | String                 |
| phone     | String | phone      | String                 |
| website   | String | website    | String                 |
| birthDate | String | birth_date | Date                   |
| login     | Hash   | login      | [Datory::Result, Hash] |
| company   | Hash   | company    | [Datory::Result, Hash] |
| addresses | Array  | addresses  | Array                  |
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
```

## Contributing

This project is intended to be a safe, welcoming space for collaboration. 
Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. 
We recommend reading the [contributing guide](./website/docs/CONTRIBUTING.md) as well.

## License

Datory is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
