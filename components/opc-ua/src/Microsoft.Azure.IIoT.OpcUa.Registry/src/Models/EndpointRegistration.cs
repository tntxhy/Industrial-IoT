// ------------------------------------------------------------
//  Copyright (c) Microsoft Corporation.  All rights reserved.
//  Licensed under the MIT License (MIT). See License.txt in the repo root for license information.
// ------------------------------------------------------------

namespace Microsoft.Azure.IIoT.OpcUa.Registry.Models {
    using Microsoft.Azure.IIoT.Hub;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Linq;
    using System;
    using System.Collections.Generic;

    /// <summary>
    /// Twin (endpoint) registration persisted and comparable
    /// </summary>
    [Serializable]
    public sealed class EndpointRegistration : BaseRegistration {

        /// <inheritdoc/>
        public override string DeviceType => "Endpoint";

        /// <summary>
        /// Device id is twin id
        /// </summary>
        public override string DeviceId => base.DeviceId ?? Id;

        /// <summary>
        /// Lower case endpoint url
        /// </summary>
        public string EndpointUrlLC =>
            EndpointRegistrationUrl?.ToLowerInvariant();

        /// <summary>
        /// Reported endpoint description url as opposed to the
        /// one that can be used to connect with.
        /// </summary>
        public string EndpointRegistrationUrl { get; set; }

        /// <summary>
        /// Security level of endpoint
        /// </summary>
        public int? SecurityLevel { get; set; }

        /// <summary>
        /// Whether endpoint is activated
        /// </summary>
        public bool? Activated { get; set; }

        /// <summary>
        /// The credential policies supported by the registered endpoint
        /// </summary>
        public Dictionary<string, JToken> AuthenticationMethods { get; set; }

        /// <summary>
        /// Endoint url for direct server access
        /// </summary>
        public string EndpointUrl { get; set; }

        /// <summary>
        /// Alternative urls
        /// </summary>
        public Dictionary<string, string> AlternativeUrls { get; set; }

        /// <summary>
        /// Default user authentication credential type
        /// </summary>
        public CredentialType? CredentialType { get; set; }

        /// <summary>
        /// Default user authentication credential to use on endpoint
        /// </summary>
        public JToken Credential { get; set; }

        /// <summary>
        /// Endpoint security policy to use.
        /// </summary>
        public string SecurityPolicy { get; set; }

        /// <summary>
        /// Security mode to use for communication
        /// </summary>
        public SecurityMode? SecurityMode { get; set; }

        /// <summary>
        /// Endpoint connectivity status
        /// </summary>
        public EndpointConnectivityState State { get; set; }

        /// <summary>
        /// Device id is the endpoint id
        /// </summary>
        [JsonProperty(PropertyName = "id")]
        public string Id => EndpointInfoModelEx.CreateEndpointId(
            ApplicationId, EndpointRegistrationUrl, SecurityMode, SecurityPolicy);

        /// <summary>
        /// Activation state
        /// </summary>
        /// <returns></returns>
        public EndpointActivationState? ActivationState {
            get {
                if (Activated == true) {
                    if (Connected) {
                        return EndpointActivationState.ActivatedAndConnected;
                    }
                    return EndpointActivationState.Activated;
                }
                return EndpointActivationState.Deactivated;
            }
            set {
                if (value == EndpointActivationState.Activated ||
                    value == EndpointActivationState.ActivatedAndConnected) {
                    Activated = true;
                }
#pragma warning disable RECS0093 // Convert 'if' to '&&' expression
                else if (value == EndpointActivationState.Deactivated) {
#pragma warning restore RECS0093 // Convert 'if' to '&&' expression
                    Activated = false;
                }
            }
        }

        /// <inheritdoc/>
        public override bool Equals(object obj) {
            var registration = obj as EndpointRegistration;
            return base.Equals(registration) &&
                (Activated ?? false) == (registration.Activated ?? false) &&
                EndpointUrlLC == registration.EndpointUrlLC &&
                SupervisorId == registration.SupervisorId &&
                JToken.DeepEquals(Credential, registration.Credential) &&
                State == registration.State &&
                CredentialType == registration.CredentialType &&
                SecurityLevel == registration.SecurityLevel &&
                SecurityPolicy == registration.SecurityPolicy &&
                SecurityMode == registration.SecurityMode &&
                AuthenticationMethods.DecodeAsList().SetEqualsSafe(
                    AuthenticationMethods.DecodeAsList(), JToken.DeepEquals);
        }

        /// <inheritdoc/>
        public static bool operator ==(EndpointRegistration r1,
            EndpointRegistration r2) =>
            EqualityComparer<EndpointRegistration>.Default.Equals(r1, r2);
        /// <inheritdoc/>
        public static bool operator !=(EndpointRegistration r1,
            EndpointRegistration r2) =>
            !(r1 == r2);

        /// <inheritdoc/>
        public override int GetHashCode() {
            var hashCode = base.GetHashCode();
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<string>.Default.GetHashCode(EndpointUrlLC);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<string>.Default.GetHashCode(ApplicationId);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<bool>.Default.GetHashCode(Activated ?? false);
            hashCode = (hashCode * -1521134295) +
                JToken.EqualityComparer.GetHashCode(Credential);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<int?>.Default.GetHashCode(SecurityLevel);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<CredentialType?>.Default.GetHashCode(CredentialType);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<EndpointConnectivityState?>.Default.GetHashCode(State);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<SecurityMode?>.Default.GetHashCode(SecurityMode);
            hashCode = (hashCode * -1521134295) +
                EqualityComparer<string>.Default.GetHashCode(SecurityPolicy);
            return hashCode;
        }

        internal bool IsInSync() {
            return _isInSync;
        }

        internal bool _isInSync;
    }
}
