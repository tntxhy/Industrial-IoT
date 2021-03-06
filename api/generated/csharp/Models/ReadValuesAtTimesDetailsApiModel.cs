// <auto-generated>
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for
// license information.
//
// Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
// Changes may cause incorrect behavior and will be lost if the code is
// regenerated.
// </auto-generated>

namespace Microsoft.Azure.IIoT.Opc.History.Models
{
    using Microsoft.Rest;
    using Newtonsoft.Json;
    using System.Collections;
    using System.Collections.Generic;
    using System.Linq;

    /// <summary>
    /// Read data at specified times
    /// </summary>
    public partial class ReadValuesAtTimesDetailsApiModel
    {
        /// <summary>
        /// Initializes a new instance of the ReadValuesAtTimesDetailsApiModel
        /// class.
        /// </summary>
        public ReadValuesAtTimesDetailsApiModel()
        {
            CustomInit();
        }

        /// <summary>
        /// Initializes a new instance of the ReadValuesAtTimesDetailsApiModel
        /// class.
        /// </summary>
        /// <param name="reqTimes">Requested datums</param>
        /// <param name="useSimpleBounds">Whether to use simple bounds</param>
        public ReadValuesAtTimesDetailsApiModel(IList<System.DateTime?> reqTimes, bool? useSimpleBounds = default(bool?))
        {
            ReqTimes = reqTimes;
            UseSimpleBounds = useSimpleBounds;
            CustomInit();
        }

        /// <summary>
        /// An initialization method that performs custom operations like setting defaults
        /// </summary>
        partial void CustomInit();

        /// <summary>
        /// Gets or sets requested datums
        /// </summary>
        [JsonProperty(PropertyName = "reqTimes")]
        public IList<System.DateTime?> ReqTimes { get; set; }

        /// <summary>
        /// Gets or sets whether to use simple bounds
        /// </summary>
        [JsonProperty(PropertyName = "useSimpleBounds")]
        public bool? UseSimpleBounds { get; set; }

        /// <summary>
        /// Validate the object.
        /// </summary>
        /// <exception cref="ValidationException">
        /// Thrown if validation fails
        /// </exception>
        public virtual void Validate()
        {
            if (ReqTimes == null)
            {
                throw new ValidationException(ValidationRules.CannotBeNull, "ReqTimes");
            }
        }
    }
}
