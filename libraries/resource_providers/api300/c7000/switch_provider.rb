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

require_relative '../../api200/switch_provider'

module OneviewCookbook
  module API300
    module C7000
      # Switch API300 C7000 provider
      class SwitchProvider < API200::SwitchProvider
        # Description                         ||  Operation  ||  Path      ||  Value
        # Add one scopeUri to the server       |  add        |  /scopeUris/-|/scopeUris/[0-#index_of_scopes_on_current_server]  |  scopeUri
        # Change the scopeUris of the server   |  replace    |  /scopeUris  |  a list of scopeUris
        # Remove one scopeUri from the server  |  remove     |  /scopeUris/[0-#index_of_scopes_on_current_server]
        def patch
          invalid_param = @context.operation.nil? || @context.path.nil?
          raise "InvalidParameters: Parameters 'operation' and 'path' must be set for patch" if invalid_param
          # TODO: Add support to Scopes (Currently not supported by oneview-sdk gem 3.1.0)
          @item.retrieve!
          @context.converge_by "Performing '#{@context.operation}' at #{@context.path} with #{@context.value} in #{@resource_name} '#{@name}'" do
            body = if @context.value
                     { op: @context.operation, path: @context.path, value: @context.value }
                   else
                     { op: @context.operation, path: @context.path }
                   end
            response = @item.client.rest_patch(@item['uri'], { 'body' => [body] }, @sdk_api_version)
            @item.client.response_handler(response)
          end
        end
      end
    end
  end
end
