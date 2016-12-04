require 'spec_helper'

describe Lita::Handlers::OdotTripcheck, lita_handler: true do
  before(:each) do
  end

  it { is_expected.to route('!tripcheck') }

  it 'will respond to tripcheck' do
    send_message '!tripcheck'
    expect(replies.last).to eq('x')
  end
end
