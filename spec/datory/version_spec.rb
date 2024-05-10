# frozen_string_literal: true

RSpec.describe Datory::VERSION do
  it { expect(Datory::VERSION::STRING).to be_present }
end
