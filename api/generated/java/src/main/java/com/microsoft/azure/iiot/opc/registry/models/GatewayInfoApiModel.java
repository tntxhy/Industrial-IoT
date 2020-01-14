/**
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License. See License.txt in the project root for
 * license information.
 *
 * Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
 * Changes may cause incorrect behavior and will be lost if the code is
 * regenerated.
 */

package com.microsoft.azure.iiot.opc.registry.models;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Gateway info model.
 */
public class GatewayInfoApiModel {
    /**
     * The gateway property.
     */
    @JsonProperty(value = "gateway", required = true)
    private GatewayApiModel gateway;

    /**
     * The supervisor property.
     */
    @JsonProperty(value = "supervisor")
    private SupervisorApiModel supervisor;

    /**
     * The publisher property.
     */
    @JsonProperty(value = "publisher")
    private PublisherApiModel publisher;

    /**
     * The discoverer property.
     */
    @JsonProperty(value = "discoverer")
    private DiscovererApiModel discoverer;

    /**
     * Get the gateway value.
     *
     * @return the gateway value
     */
    public GatewayApiModel gateway() {
        return this.gateway;
    }

    /**
     * Set the gateway value.
     *
     * @param gateway the gateway value to set
     * @return the GatewayInfoApiModel object itself.
     */
    public GatewayInfoApiModel withGateway(GatewayApiModel gateway) {
        this.gateway = gateway;
        return this;
    }

    /**
     * Get the supervisor value.
     *
     * @return the supervisor value
     */
    public SupervisorApiModel supervisor() {
        return this.supervisor;
    }

    /**
     * Set the supervisor value.
     *
     * @param supervisor the supervisor value to set
     * @return the GatewayInfoApiModel object itself.
     */
    public GatewayInfoApiModel withSupervisor(SupervisorApiModel supervisor) {
        this.supervisor = supervisor;
        return this;
    }

    /**
     * Get the publisher value.
     *
     * @return the publisher value
     */
    public PublisherApiModel publisher() {
        return this.publisher;
    }

    /**
     * Set the publisher value.
     *
     * @param publisher the publisher value to set
     * @return the GatewayInfoApiModel object itself.
     */
    public GatewayInfoApiModel withPublisher(PublisherApiModel publisher) {
        this.publisher = publisher;
        return this;
    }

    /**
     * Get the discoverer value.
     *
     * @return the discoverer value
     */
    public DiscovererApiModel discoverer() {
        return this.discoverer;
    }

    /**
     * Set the discoverer value.
     *
     * @param discoverer the discoverer value to set
     * @return the GatewayInfoApiModel object itself.
     */
    public GatewayInfoApiModel withDiscoverer(DiscovererApiModel discoverer) {
        this.discoverer = discoverer;
        return this;
    }

}