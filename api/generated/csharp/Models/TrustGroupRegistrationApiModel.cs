// <auto-generated>
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// </auto-generated>

namespace Microsoft.Azure.IIoT.Opc.Vault.Models
{
    using Microsoft.Rest;
    using Newtonsoft.Json;
    using System.Linq;

    /// <summary>
    /// Trust group registration model
    /// </summary>
    public partial class TrustGroupRegistrationApiModel
    {
        /// <summary>
        /// Initializes a new instance of the TrustGroupRegistrationApiModel
        /// class.
        /// </summary>
        public TrustGroupRegistrationApiModel()
        {
            CustomInit();
        }

        /// <summary>
        /// Initializes a new instance of the TrustGroupRegistrationApiModel
        /// class.
        /// </summary>
        /// <param name="id">The registered id of the trust group</param>
        /// <param name="group">Trust group</param>
        public TrustGroupRegistrationApiModel(string id, TrustGroupApiModel group)
        {
            Id = id;
            Group = group;
            CustomInit();
        }

        /// <summary>
        /// An initialization method that performs custom operations like setting defaults
        /// </summary>
        partial void CustomInit();

        /// <summary>
        /// Gets or sets the registered id of the trust group
        /// </summary>
        [JsonProperty(PropertyName = "id")]
        public string Id { get; set; }

        /// <summary>
        /// Gets or sets trust group
        /// </summary>
        [JsonProperty(PropertyName = "group")]
        public TrustGroupApiModel Group { get; set; }

        /// <summary>
        /// Validate the object.
        /// </summary>
        /// <exception cref="ValidationException">
        /// Thrown if validation fails
        /// </exception>
        public virtual void Validate()
        {
            if (Id == null)
            {
                throw new ValidationException(ValidationRules.CannotBeNull, "Id");
            }
            if (Group == null)
            {
                throw new ValidationException(ValidationRules.CannotBeNull, "Group");
            }
            if (Group != null)
            {
                Group.Validate();
            }
        }
    }
}
