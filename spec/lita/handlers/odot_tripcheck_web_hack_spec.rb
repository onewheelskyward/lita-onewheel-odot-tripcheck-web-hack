require 'spec_helper'

describe Lita::Handlers::OdotTripcheckWebHack, lita_handler: true do
  before(:each) do
  end

  it { is_expected.to route('!tripcheck blue') }

  it 'will respond to tripcheck' do
    send_message '!tripcheck govy'
    expect(replies.last).to include('https://tripcheck.com/RoadCams/cams/US26%20at%20Govn%20Camp%20Maint_pid1899.JPG')
  end
end
