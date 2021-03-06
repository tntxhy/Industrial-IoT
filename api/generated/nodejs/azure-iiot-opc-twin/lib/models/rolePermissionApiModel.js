/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 *
 * Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
 * Changes may cause incorrect behavior and will be lost if the code is
 * regenerated.
 */

'use strict';

/**
 * Role permission model
 *
 */
class RolePermissionApiModel {
  /**
   * Create a RolePermissionApiModel.
   * @property {string} roleId Identifier of the role object.
   * @property {string} [permissions] Permissions assigned for the role.
   * Possible values include: 'Browse', 'ReadRolePermissions',
   * 'WriteAttribute', 'WriteRolePermissions', 'WriteHistorizing', 'Read',
   * 'Write', 'ReadHistory', 'InsertHistory', 'ModifyHistory', 'DeleteHistory',
   * 'ReceiveEvents', 'Call', 'AddReference', 'RemoveReference', 'DeleteNode',
   * 'AddNode'
   */
  constructor() {
  }

  /**
   * Defines the metadata of RolePermissionApiModel
   *
   * @returns {object} metadata of RolePermissionApiModel
   *
   */
  mapper() {
    return {
      required: false,
      serializedName: 'RolePermissionApiModel',
      type: {
        name: 'Composite',
        className: 'RolePermissionApiModel',
        modelProperties: {
          roleId: {
            required: true,
            serializedName: 'roleId',
            type: {
              name: 'String'
            }
          },
          permissions: {
            required: false,
            serializedName: 'permissions',
            type: {
              name: 'Enum',
              allowedValues: [ 'Browse', 'ReadRolePermissions', 'WriteAttribute', 'WriteRolePermissions', 'WriteHistorizing', 'Read', 'Write', 'ReadHistory', 'InsertHistory', 'ModifyHistory', 'DeleteHistory', 'ReceiveEvents', 'Call', 'AddReference', 'RemoveReference', 'DeleteNode', 'AddNode' ]
            }
          }
        }
      }
    };
  }
}

module.exports = RolePermissionApiModel;
