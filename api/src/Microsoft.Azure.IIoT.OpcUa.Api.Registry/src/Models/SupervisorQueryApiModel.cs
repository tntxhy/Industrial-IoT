// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace Microsoft.Azure.IIoT.OpcUa.Api.Registry.Models {
    using Newtonsoft.Json;

    /// <summary>
    /// Supervisor registration query
    /// </summary>
    public class SupervisorQueryApiModel {

        /// <summary>
        /// Site for the supervisors
        /// </summary>
        [JsonProperty(PropertyName = "siteId",
            NullValueHandling = NullValueHandling.Ignore)]
        public string SiteId { get; set; }

        /// <summary>
        /// Discovery mode of supervisor
        /// </summary>
        [JsonProperty(PropertyName = "discovery",
            NullValueHandling = NullValueHandling.Ignore)]
        public DiscoveryMode? Discovery { get; set; }

        /// <summary>
        /// Included connected or disconnected
        /// </summary>
        [JsonProperty(PropertyName = "connected",
            NullValueHandling = NullValueHandling.Ignore)]
        public bool? Connected { get; set; }
    }
}
