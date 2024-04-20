# frozen_string_literal: true

RSpec.describe Datory::VERSION do
  it { expect(Datory::VERSION::STRING).not_to be_nil }
end
