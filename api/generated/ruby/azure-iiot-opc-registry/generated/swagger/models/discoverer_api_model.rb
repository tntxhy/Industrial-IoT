# encoding: utf-8
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
#
# Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module azure.iiot.opc.registry
  module Models
    #
    # Discoverer registration model
    #
    class DiscovererApiModel
      # @return [String] Discoverer id
      attr_accessor :id

      # @return [String] Site of the discoverer
      attr_accessor :site_id

      # @return [DiscoveryMode] Possible values include: 'Off', 'Local',
      # 'Network', 'Fast', 'Scan'
      attr_accessor :discovery

      # @return [DiscoveryConfigApiModel]
      attr_accessor :discovery_config

      # @return [TraceLogLevel] Possible values include: 'Error',
      # 'Information', 'Debug', 'Verbose'
      attr_accessor :log_level

      # @return [Boolean] Whether the registration is out of sync between
      # client (module) and server (service) (default: false).
      attr_accessor :out_of_sync

      # @return [Boolean] Whether discoverer is connected on this registration
      attr_accessor :connected


      #
      # Mapper for DiscovererApiModel class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'DiscovererApiModel',
          type: {
            name: 'Composite',
            class_name: 'DiscovererApiModel',
            model_properties: {
              id: {
                client_side_validation: true,
                required: true,
                serialized_name: 'id',
                type: {
                  name: 'String'
                }
              },
              site_id: {
                client_side_validation: true,
                required: false,
                serialized_name: 'siteId',
                type: {
                  name: 'String'
                }
              },
              discovery: {
                client_side_validation: true,
                required: false,
                serialized_name: 'discovery',
                type: {
                  name: 'Enum',
                  module: 'DiscoveryMode'
                }
              },
              discovery_config: {
                client_side_validation: true,
                required: false,
                serialized_name: 'discoveryConfig',
                type: {
                  name: 'Composite',
                  class_name: 'DiscoveryConfigApiModel'
                }
              },
              log_level: {
                client_side_validation: true,
                required: false,
                serialized_name: 'logLevel',
                type: {
                  name: 'Enum',
                  module: 'TraceLogLevel'
                }
              },
              out_of_sync: {
                client_side_validation: true,
                required: false,
                serialized_name: 'outOfSync',
                type: {
                  name: 'Boolean'
                }
              },
              connected: {
                client_side_validation: true,
                required: false,
                serialized_name: 'connected',
                type: {
                  name: 'Boolean'
                }
              }
            }
          }
        }
      end
    end
  end
end