require 'spec_helper'

describe Lita::Handlers::OnewheelOdotTripcheckWebHack, lita_handler: true do
  before(:each) do
  end

  it { is_expected.to route_command('tripcheck blue') }
  it { is_expected.to route_command('tripcheck') }
  it { is_expected.to route_command('sandycam') }

  it 'will respond to tripcheck' do
    send_command 'tripcheck govy'
    expect(replies.last).to include('https://tripcheck.com/RoadCams/cams/US26%20at%20Govn%20Camp%20Maint_pid1899.JPG')
  end

  it 'will list tripchecks' do
    send_command 'tripcheck'
    expect(replies.last).to eq('Cameras available include: Hood River, 26 at 35, 26 at Snow Bunny, 26 at Govy, 26 at Govy Loop Rd, 26 at Frog Lake, 26 at Blue Box Pass, Sandy Blvd in Hollywood')
  end

  it 'will not rand sandy' do
    send_command 'tripcheck sandy'
    expect(replies.last).to_not include('rand=')
  end

  it 'sandycam' do
    send_command 'sandycam'
    expect(replies.last).to eq('https://launchpad.pin13.net/cam/sandy.jpg')
  end
end
