require_relative './../../../spec_helper'

describe 'oneview_test_api300_synergy::sas_interconnect_set_uid_light' do
  let(:resource_name) { 'sas_interconnect' }
  let(:klass) { OneviewSDK::API300::Synergy::SASInterconnect }
  include_context 'chef context'

  it 'sets the SASInterconnect UID light to a valid value' do
    allow_any_instance_of(klass).to receive(:retrieve!).and_return(true)
    expect_any_instance_of(klass).to receive(:patch).with('replace', '/uidState', anything)
    expect(real_chef_run).to set_oneview_sas_interconnect_uid_light('SASInterconnect1')
  end
end

describe 'oneview_test_api300_synergy::sas_interconnect_set_uid_light_invalid' do
  let(:resource_name) { 'sas_interconnect' }
  let(:klass) { OneviewSDK::API300::Synergy::SASInterconnect }
  include_context 'chef context'

  it 'fails if uid_light_state property is not set' do
    allow_any_instance_of(klass).to receive(:retrieve!).and_return(true)
    expect { real_chef_run }.to raise_error(RuntimeError, /Unspecified property: 'uid_light_state'/)
  end
end
