# (c) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

my_client = {
  url: ENV['ONEVIEWSDK_URL'],
  user: ENV['ONEVIEWSDK_USER'],
  password: ENV['ONEVIEWSDK_PASSWORD']
}

# Example: Create and manage a new ethernet network
oneview_ethernet_network 'Eth1' do
  client my_client
  data(
    vlanId: 1001,
    purpose: 'General',
    smartLink: false,
    privateNetwork: false
  )
end

# Example: Create a new ethernet network only if it doesn't exist.
# No updates will be made if the network exists but attributes differ
oneview_ethernet_network 'Eth1' do
  client my_client
  data(
    vlanId: 1001,
    purpose: 'General',
    smartLink: false,
    privateNetwork: false
  )
  action :create_if_missing
end

# Example: Delete an ethernet network
oneview_ethernet_network 'Eth1' do
  client my_client
  action :delete
end
