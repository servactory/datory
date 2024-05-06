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
user = User.find(...)

UserDto.serialize(user) # => { ... }
```

#### Deserialize

```ruby
UserDto.deserialize(json) # => Datory::Result
```

#### Form

For serialization, the `form` method is also available.
This prepares a `Form` object, which has a set of additional methods such as `valid?` and `invalid?`.

```ruby
form = UserDto.form(user)

form.target # => UserDto
form.model # => { ... }

form.valid? # => true
form.invalid? # => false

form.serialize # => { ... }
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

  date :birthDate, to: :birth_date

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

  duration :lifetime
  
  datetime :registered_at
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
integer :attempts, min: 1, max: 10
```

#### float

```ruby
float :interest_rate
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

#### duration

```ruby
duration :lifetime
```

#### date

```ruby
date :birth_date
```

#### time

```ruby
time :registered_at
```

#### datetime

```ruby
datetime :registered_at
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
#<Datory::Info::Result:0x000000011eecd7d0 @attributes={:id=>{:from=>{:name=>:id, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:uuid}, :to=>{:name=>:id, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:uuid, :required=>true, :include=>nil}}, :firstname=>{:from=>{:name=>:firstname, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:first_name, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :lastname=>{:from=>{:name=>:lastname, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:last_name, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :email=>{:from=>{:name=>:email, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:email, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :phone=>{:from=>{:name=>:phone, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:phone, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :website=>{:from=>{:name=>:website, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:website, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :birthDate=>{:from=>{:name=>:birthDate, :type=>String, :min=>nil, :max=>nil, :consists_of=>false, :format=>:date}, :to=>{:name=>:birth_date, :type=>Date, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>nil}}, :login=>{:from=>{:name=>:login, :type=>Hash, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:login, :type=>[Datory::Result, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>Usual::Example1::UserLogin}}, :company=>{:from=>{:name=>:company, :type=>Hash, :min=>nil, :max=>nil, :consists_of=>false, :format=>nil}, :to=>{:name=>:company, :type=>[Datory::Result, Hash], :min=>nil, :max=>nil, :consists_of=>false, :format=>nil, :required=>true, :include=>Usual::Example1::UserCompany}}, :addresses=>{:from=>{:name=>:addresses, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Datory::Result, Hash], :format=>nil}, :to=>{:name=>:addresses, :type=>Array, :min=>nil, :max=>nil, :consists_of=>[Datory::Result, Hash], :format=>nil, :required=>true, :include=>Usual::Example1::UserAddress}}}>
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
