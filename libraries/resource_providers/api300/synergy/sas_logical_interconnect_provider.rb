# (c) Copyright 2017 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied. See the License for the
# specific language governing permissions and limitations under the License.

require_relative '../../api200/logical_interconnect_provider'

module OneviewCookbook
  module API300
    module Synergy
      # LogicalInterconnect API300 Synergy resource provider methods
      class SASLogicalInterconnectProvider < API200::LogicalInterconnectProvider
        def get_serial_number(drive_id)
          return unless drive_id
          temp_res = resource_named(:DriveEnclosure).find_by(@item.client, name: drive_id).first
          return temp_res['serialNumber'] if temp_res
          drive_id
        end

        def replace_drive_enclosure
          old_sn = @item.data.delete('oldSerialNumber') || get_serial_number(@context.old_drive_enclosure)
          raise 'InvalidParameters: Old drive enclosure name or serial number must be set and should be valid' unless old_sn
          new_sn = @item.data.delete('newSerialNumber') || get_serial_number(@context.new_drive_enclosure)
          raise 'InvalidParameters: New drive enclosure name or serial number must be set and should be valid' unless new_sn
          raise "ResourceNotFound: The '#{@resource_name}' '#{@name}' could not be found" unless @item.retrieve!
          @context.converge_by "Replacing drive enclosure '#{old_sn}' by '#{new_sn}'" do
            @item.replace_drive_enclosure(old_sn, new_sn)
          end
        end
      end
    end
  end
end
