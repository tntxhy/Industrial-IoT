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
    # Application with optional list of endpoints
    #
    class ApplicationRecordApiModel
      # @return [Integer] Record id
      attr_accessor :record_id

      # @return [ApplicationInfoApiModel] Application information
      attr_accessor :application


      #
      # Mapper for ApplicationRecordApiModel class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'ApplicationRecordApiModel',
          type: {
            name: 'Composite',
            class_name: 'ApplicationRecordApiModel',
            model_properties: {
              record_id: {
                client_side_validation: true,
                required: true,
                serialized_name: 'recordId',
                type: {
                  name: 'Number'
                }
              },
              application: {
                client_side_validation: true,
                required: true,
                serialized_name: 'application',
                type: {
                  name: 'Composite',
                  class_name: 'ApplicationInfoApiModel'
                }
              }
            }
          }
        }
      end
    end
  end
end
