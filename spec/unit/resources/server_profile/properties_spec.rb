require_relative './../../../spec_helper'

describe 'oneview_test::server_profile_properties' do
  let(:resource_name) { 'server_profile' }
  include_context 'chef context'
  include_context 'shared context'

  it 'loads the associated resources' do
    sh1 = OneviewSDK::ServerHardware.new(@client, name: 'ServerHardware1', uri: 'rest/fake0')
    en1 = OneviewSDK::EthernetNetwork.new(@client, name: 'EthernetNetwork1', uri: 'rest/fake1')
    allow(OneviewSDK::ServerHardware).to receive(:find_by).with(anything, name: 'ServerHardware1').and_return([sh1])
    allow(OneviewSDK::EthernetNetwork).to receive(:find_by).with(anything, name: 'EthernetNetwork1').and_return([en1])

    expect_any_instance_of(OneviewSDK::ServerProfile).to receive(:set_server_hardware).with(sh1)
    expect_any_instance_of(OneviewSDK::ServerProfile).to receive(:add_connection).with(en1, 'it' => 'works')

    # Mock create
    expect_any_instance_of(OneviewSDK::ServerProfile).to receive(:exists?).and_return(false)
    expect_any_instance_of(OneviewSDK::ServerProfile).to receive(:create).and_return(true)

    expect(real_chef_run).to create_oneview_server_profile('ServerProfile4')
  end
end
