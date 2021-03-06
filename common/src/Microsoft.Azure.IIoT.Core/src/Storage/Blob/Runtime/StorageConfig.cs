// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace Microsoft.Azure.IIoT.Storage.Blob.Runtime {
    using Microsoft.Azure.IIoT.Storage.Blob;
    using Microsoft.Azure.IIoT.Utils;
    using Microsoft.Extensions.Configuration;
    using System;

    /// <summary>
    /// Blob storage configuration
    /// </summary>
    public class StorageConfig : ConfigBase, IStorageConfig {

        /// <summary>
        /// Configuration keys
        /// </summary>
        private const string kBlobStorageConnStringKey = "BlobStorageConnectionString";

        /// <summary> Storage </summary>
        public string BlobStorageConnString {
            get {
                var account = GetStringOrDefault("PCS_ASA_DATA_AZUREBLOB_ACCOUNT",
                    GetStringOrDefault("PCS_IOTHUBREACT_AZUREBLOB_ACCOUNT", null));
                var key = GetStringOrDefault("PCS_ASA_DATA_AZUREBLOB_KEY",
                    GetStringOrDefault("PCS_IOTHUBREACT_AZUREBLOB_KEY", null));
                var suffix = GetStringOrDefault("PCS_ASA_DATA_AZUREBLOB_ENDPOINT_SUFFIX",
                    GetStringOrDefault("PCS_IOTHUBREACT_AZUREBLOB_ENDPOINT_SUFFIX", "core.windows.net"));
                if (string.IsNullOrEmpty(account) || string.IsNullOrEmpty(key)) {
                    var cs = GetStringOrDefault(kBlobStorageConnStringKey, GetStringOrDefault(
                        _serviceId + "_STORE_CS", GetStringOrDefault("_STORE_CS", null)))?.Trim();
                    if (string.IsNullOrEmpty(cs)) {
                        return null;
                    }
                    return cs;
                }
                return "DefaultEndpointsProtocol=https;" +
                    $"EndpointSuffix={suffix};AccountName={account};AccountKey={key}";
            }
        }

        /// <summary>
        /// Configuration constructor
        /// </summary>
        /// <param name="serviceId"></param>
        /// <param name="configuration"></param>
        public StorageConfig(IConfigurationRoot configuration, string serviceId = "") :
            base(configuration) {
            _serviceId = serviceId ?? throw new ArgumentNullException(nameof(serviceId));
        }

        private readonly string _serviceId;
    }
}
