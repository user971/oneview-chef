# (c) Copyright 2016-2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

OneviewCookbook::ResourceBaseProperties.load(self)

property :power_state, [String, Symbol], regex: /^(on|off)$/i # Used in :set_power_state action only
property :refresh_options, Hash, default: {}                  # Used in :refresh action only

default_action :add_if_missing

action :add_if_missing do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :add_if_missing)
end

action :remove do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :remove)
end

action :update_ilo_firmware do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :update_ilo_firmware)
end

action :set_power_state do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :set_power_state)
end

action :refresh do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :refresh)
end

action :patch do
  OneviewCookbook::Helper.do_resource_action(self, :ServerHardware, :patch)
end
