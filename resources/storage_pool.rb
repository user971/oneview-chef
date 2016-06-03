################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

Opscode::OneviewResourceBaseProperties.load(self)

property :storage_system_ip
property :storage_system_name

default_action :add

action_class do
  include Opscode::OneviewHelper
  include Opscode::OneviewResourceBase
end

action :add do
  item = load_resource
  item['poolName'] = new_resource.name
  if new_resource.storage_system_ip
    storage_system = OneviewSDK::StorageSystem.new(item.client, credentials: { ip_hostname: new_resource.storage_system_ip })
  elsif new_resource.storage_system_name
    storage_system = OneviewSDK::StorageSystem.new(item.client, name: new_resource.storage_system_name)
  end
  storage_system.retrieve!
  item.set_storage_system(storage_system)
  create_or_update(item)
end

action :remove do
  delete
end
