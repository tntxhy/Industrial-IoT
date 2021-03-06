# encoding: utf-8
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
#
# Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module azure.iiot.opc.twin
  module Models
    #
    # Method call response model
    #
    class MethodCallResponseApiModel
      # @return [Array<MethodCallArgumentApiModel>] Output results
      attr_accessor :results

      # @return [ServiceResultApiModel] Service result in case of error
      attr_accessor :error_info


      #
      # Mapper for MethodCallResponseApiModel class as Ruby Hash.
      # This will be used for serialization/deserialization.
      #
      def self.mapper()
        {
          client_side_validation: true,
          required: false,
          serialized_name: 'MethodCallResponseApiModel',
          type: {
            name: 'Composite',
            class_name: 'MethodCallResponseApiModel',
            model_properties: {
              results: {
                client_side_validation: true,
                required: false,
                serialized_name: 'results',
                type: {
                  name: 'Sequence',
                  element: {
                      client_side_validation: true,
                      required: false,
                      serialized_name: 'MethodCallArgumentApiModelElementType',
                      type: {
                        name: 'Composite',
                        class_name: 'MethodCallArgumentApiModel'
                      }
                  }
                }
              },
              error_info: {
                client_side_validation: true,
                required: false,
                serialized_name: 'errorInfo',
                type: {
                  name: 'Composite',
                  class_name: 'ServiceResultApiModel'
                }
              }
            }
          }
        }
      end
    end
  end
end
