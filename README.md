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

## Attribute declaration

### Basic

#### attribute

```ruby
attribute :firstname, from: String, to: :first_name, as: String
```

#### string

```ruby
string :first_name
```

#### integer

```ruby
integer :attempts
```

#### float

```ruby
integer :interest_rate
```

### Helpers

#### uuid

It will also check that the value matches the UUID format.

```ruby
uuid :id
```

#### money

It will prepare two attributes `*_cents` and `*_currency`.

```ruby
money :price
```

### Nesting

#### one

```ruby
one :company, include: UserCompanyDto
```

#### many

```ruby
many :addresses, include: UserAddressDto
```

## Object information

### Info

```ruby
UserDto.info
```

```
#<Datory::Info::Result:0x00000001069c45d0 @attributes={:id=>{:from=>String, :to=>:id, :as=>String, :include=>nil}, :firstname=>{:from=>String, :to=>:first_name, :as=>String, :include=>nil}, :lastname=>{:from=>String, :to=>:last_name, :as=>String, :include=>nil}, :email=>{:from=>String, :to=>:email, :as=>String, :include=>nil}, :phone=>{:from=>String, :to=>:phone, :as=>String, :include=>nil}, :website=>{:from=>String, :to=>:website, :as=>String, :include=>nil}, :birthDate=>{:from=>String, :to=>:birth_date, :as=>Date, :include=>nil}, :login=>{:from=>Hash, :to=>:login, :as=>[Datory::Result, Hash], :include=>Usual::Example1::UserLogin}, :company=>{:from=>Hash, :to=>:company, :as=>[Datory::Result, Hash], :include=>Usual::Example1::UserCompany}, :addresses=>{:from=>Array, :to=>:addresses, :as=>Array, :include=>Usual::Example1::UserAddress}}>
```

### Describe

```ruby
UserDto.describe
```

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
|                                         UserDto                                         |
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
```

## Contributing

This project is intended to be a safe, welcoming space for collaboration. 
Contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct. 
We recommend reading the [contributing guide](./CONTRIBUTING.md) as well.

## License

Datory is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
