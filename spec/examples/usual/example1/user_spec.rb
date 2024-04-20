# frozen_string_literal: true

RSpec.describe Usual::Example1::User do
  subject(:perform) { described_class.build!(**attributes) }

  let(:attributes) do
    {
      first_name: first_name,
      middle_name: middle_name,
      last_name: last_name
    }
  end

  let(:first_name) { "John" }
  let(:middle_name) { "Fitzgerald" }
  let(:last_name) { "Kennedy" }

  it do
    puts
    puts
    puts perform.inspect
    puts
    puts
  end
end
