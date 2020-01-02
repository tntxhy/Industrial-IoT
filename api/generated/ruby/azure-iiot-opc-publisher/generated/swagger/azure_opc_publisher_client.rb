# encoding: utf-8
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See License.txt in the project root for
# license information.
#
# Code generated by Microsoft (R) AutoRest Code Generator 1.0.0.0
# Changes may cause incorrect behavior and will be lost if the code is
# regenerated.

module azure.iiot.opc.publisher
  #
  # A service client - single point of access to the REST API.
  #
  class AzureOpcPublisherClient < MsRest::ServiceClient
    include MsRest::Serialization

    # @return [String] the base URI of the service.
    attr_accessor :base_url

    # @return Subscription credentials which uniquely identify client
    # subscription.
    attr_accessor :credentials

    #
    # Creates initializes a new instance of the AzureOpcPublisherClient class.
    # @param credentials [MsRest::ServiceClientCredentials] credentials to authorize HTTP requests made by the service client.
    # @param base_url [String] the base URI of the service.
    # @param options [Array] filters to be applied to the HTTP requests.
    #
    def initialize(credentials = nil, base_url = nil, options = nil)
      super(credentials, options)
      @base_url = base_url || 'http://localhost/publisher'

      fail ArgumentError, 'invalid type of credentials input parameter' unless credentials.is_a?(MsRest::ServiceClientCredentials) unless credentials.nil?
      @credentials = credentials

      add_telemetry
    end

    #
    # Makes a request and returns the body of the response.
    # @param method [Symbol] with any of the following values :get, :put, :post, :patch, :delete.
    # @param path [String] the path, relative to {base_url}.
    # @param options [Hash{String=>String}] specifying any request options like :body.
    # @return [Hash{String=>String}] containing the body of the response.
    # Example:
    #
    #  request_content = "{'location':'westus','tags':{'tag1':'val1','tag2':'val2'}}"
    #  path = "/path"
    #  options = {
    #    body: request_content,
    #    query_params: {'api-version' => '2016-02-01'}
    #  }
    #  result = @client.make_request(:put, path, options)
    #
    def make_request(method, path, options = {})
      result = make_request_with_http_info(method, path, options)
      result.body unless result.nil?
    end

    #
    # Makes a request and returns the operation response.
    # @param method [Symbol] with any of the following values :get, :put, :post, :patch, :delete.
    # @param path [String] the path, relative to {base_url}.
    # @param options [Hash{String=>String}] specifying any request options like :body.
    # @return [MsRest::HttpOperationResponse] Operation response containing the request, response and status.
    #
    def make_request_with_http_info(method, path, options = {})
      result = make_request_async(method, path, options).value!
      result.body = result.response.body.to_s.empty? ? nil : JSON.load(result.response.body)
      result
    end

    #
    # Makes a request asynchronously.
    # @param method [Symbol] with any of the following values :get, :put, :post, :patch, :delete.
    # @param path [String] the path, relative to {base_url}.
    # @param options [Hash{String=>String}] specifying any request options like :body.
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def make_request_async(method, path, options = {})
      fail ArgumentError, 'method is nil' if method.nil?
      fail ArgumentError, 'path is nil' if path.nil?

      request_url = options[:base_url] || @base_url
      if(!options[:headers].nil? && !options[:headers]['Content-Type'].nil?)
        @request_headers['Content-Type'] = options[:headers]['Content-Type']
      end

      request_headers = @request_headers
      options.merge!({headers: request_headers.merge(options[:headers] || {})})
      options.merge!({credentials: @credentials}) unless @credentials.nil?

      super(request_url, method, path, options)
    end

    #
    # Subscribe to receive samples
    #
    # Register a client to receive publisher samples through SignalR.
    #
    # @param endpoint_id [String] The endpoint to subscribe to
    # @param user_id [String] The user id that will receive publisher
    # samples.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    #
    def subscribe(endpoint_id, user_id:nil, custom_headers:nil)
      response = subscribe_async(endpoint_id, user_id:user_id, custom_headers:custom_headers).value!
      nil
    end

    #
    # Subscribe to receive samples
    #
    # Register a client to receive publisher samples through SignalR.
    #
    # @param endpoint_id [String] The endpoint to subscribe to
    # @param user_id [String] The user id that will receive publisher
    # samples.
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def subscribe_with_http_info(endpoint_id, user_id:nil, custom_headers:nil)
      subscribe_async(endpoint_id, user_id:user_id, custom_headers:custom_headers).value!
    end

    #
    # Subscribe to receive samples
    #
    # Register a client to receive publisher samples through SignalR.
    #
    # @param endpoint_id [String] The endpoint to subscribe to
    # @param user_id [String] The user id that will receive publisher
    # samples.
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def subscribe_async(endpoint_id, user_id:nil, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json-patch+json; charset=utf-8'

      # Serialize Request
      request_mapper = {
        client_side_validation: true,
        required: false,
        serialized_name: 'userId',
        type: {
          name: 'String'
        }
      }
      request_content = self.serialize(request_mapper,  user_id)
      request_content = request_content != nil ? JSON.generate(request_content, quirks_mode: true) : nil

      path_template = 'v2/monitor/{endpointId}/samples'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id},
          body: request_content,
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:put, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end


        result
      end

      promise.execute
    end

    #
    # Unsubscribe from receiving samples.
    #
    # Unregister a client and stop it from receiving samples.
    #
    # @param endpoint_id [String] The endpoint to unsubscribe from
    # @param user_id [String] The user id that will not receive
    # any more published samples
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    #
    def unsubscribe(endpoint_id, user_id, custom_headers:nil)
      response = unsubscribe_async(endpoint_id, user_id, custom_headers:custom_headers).value!
      nil
    end

    #
    # Unsubscribe from receiving samples.
    #
    # Unregister a client and stop it from receiving samples.
    #
    # @param endpoint_id [String] The endpoint to unsubscribe from
    # @param user_id [String] The user id that will not receive
    # any more published samples
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def unsubscribe_with_http_info(endpoint_id, user_id, custom_headers:nil)
      unsubscribe_async(endpoint_id, user_id, custom_headers:custom_headers).value!
    end

    #
    # Unsubscribe from receiving samples.
    #
    # Unregister a client and stop it from receiving samples.
    #
    # @param endpoint_id [String] The endpoint to unsubscribe from
    # @param user_id [String] The user id that will not receive
    # any more published samples
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def unsubscribe_async(endpoint_id, user_id, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?
      fail ArgumentError, 'user_id is nil' if user_id.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'
      path_template = 'v2/monitor/{endpointId}/samples/{userId}'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id,'userId' => user_id},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:delete, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end


        result
      end

      promise.execute
    end

    #
    # Start publishing node values
    #
    # Start publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStartRequestApiModel] The publish request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [PublishStartResponseApiModel] operation results.
    #
    def start_publishing_values(endpoint_id, request, custom_headers:nil)
      response = start_publishing_values_async(endpoint_id, request, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Start publishing node values
    #
    # Start publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStartRequestApiModel] The publish request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def start_publishing_values_with_http_info(endpoint_id, request, custom_headers:nil)
      start_publishing_values_async(endpoint_id, request, custom_headers:custom_headers).value!
    end

    #
    # Start publishing node values
    #
    # Start publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStartRequestApiModel] The publish request
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def start_publishing_values_async(endpoint_id, request, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?
      fail ArgumentError, 'request is nil' if request.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json-patch+json; charset=utf-8'

      # Serialize Request
      request_mapper = azure.iiot.opc.publisher::Models::PublishStartRequestApiModel.mapper()
      request_content = self.serialize(request_mapper,  request)
      request_content = request_content != nil ? JSON.generate(request_content, quirks_mode: true) : nil

      path_template = 'v2/publish/{endpointId}/start'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id},
          body: request_content,
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:post, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end

        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = azure.iiot.opc.publisher::Models::PublishStartResponseApiModel.mapper()
            result.body = self.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Stop publishing node values
    #
    # Stop publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStopRequestApiModel] The unpublish request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [PublishStopResponseApiModel] operation results.
    #
    def stop_publishing_values(endpoint_id, request, custom_headers:nil)
      response = stop_publishing_values_async(endpoint_id, request, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Stop publishing node values
    #
    # Stop publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStopRequestApiModel] The unpublish request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def stop_publishing_values_with_http_info(endpoint_id, request, custom_headers:nil)
      stop_publishing_values_async(endpoint_id, request, custom_headers:custom_headers).value!
    end

    #
    # Stop publishing node values
    #
    # Stop publishing variable node values to IoT Hub.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishStopRequestApiModel] The unpublish request
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def stop_publishing_values_async(endpoint_id, request, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?
      fail ArgumentError, 'request is nil' if request.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json-patch+json; charset=utf-8'

      # Serialize Request
      request_mapper = azure.iiot.opc.publisher::Models::PublishStopRequestApiModel.mapper()
      request_content = self.serialize(request_mapper,  request)
      request_content = request_content != nil ? JSON.generate(request_content, quirks_mode: true) : nil

      path_template = 'v2/publish/{endpointId}/stop'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id},
          body: request_content,
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:post, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end

        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = azure.iiot.opc.publisher::Models::PublishStopResponseApiModel.mapper()
            result.body = self.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Get next set of published nodes
    #
    # Returns next set of currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param continuation_token [String] The continuation token to continue with
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [PublishedItemListResponseApiModel] operation results.
    #
    def get_next_list_of_published_nodes(endpoint_id, continuation_token, custom_headers:nil)
      response = get_next_list_of_published_nodes_async(endpoint_id, continuation_token, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Get next set of published nodes
    #
    # Returns next set of currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param continuation_token [String] The continuation token to continue with
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def get_next_list_of_published_nodes_with_http_info(endpoint_id, continuation_token, custom_headers:nil)
      get_next_list_of_published_nodes_async(endpoint_id, continuation_token, custom_headers:custom_headers).value!
    end

    #
    # Get next set of published nodes
    #
    # Returns next set of currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param continuation_token [String] The continuation token to continue with
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def get_next_list_of_published_nodes_async(endpoint_id, continuation_token, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?
      fail ArgumentError, 'continuation_token is nil' if continuation_token.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'
      path_template = 'v2/publish/{endpointId}'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id},
          query_params: {'continuationToken' => continuation_token},
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:get, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end

        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = azure.iiot.opc.publisher::Models::PublishedItemListResponseApiModel.mapper()
            result.body = self.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Get currently published nodes
    #
    # Returns currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishedItemListRequestApiModel] The list request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [PublishedItemListResponseApiModel] operation results.
    #
    def get_first_list_of_published_nodes(endpoint_id, request, custom_headers:nil)
      response = get_first_list_of_published_nodes_async(endpoint_id, request, custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Get currently published nodes
    #
    # Returns currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishedItemListRequestApiModel] The list request
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def get_first_list_of_published_nodes_with_http_info(endpoint_id, request, custom_headers:nil)
      get_first_list_of_published_nodes_async(endpoint_id, request, custom_headers:custom_headers).value!
    end

    #
    # Get currently published nodes
    #
    # Returns currently published node ids for an endpoint.
    # The endpoint must be activated and connected and the module client
    # and server must trust each other.
    #
    # @param endpoint_id [String] The identifier of the activated endpoint.
    # @param request [PublishedItemListRequestApiModel] The list request
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def get_first_list_of_published_nodes_async(endpoint_id, request, custom_headers:nil)
      fail ArgumentError, 'endpoint_id is nil' if endpoint_id.nil?
      fail ArgumentError, 'request is nil' if request.nil?


      request_headers = {}
      request_headers['Content-Type'] = 'application/json-patch+json; charset=utf-8'

      # Serialize Request
      request_mapper = azure.iiot.opc.publisher::Models::PublishedItemListRequestApiModel.mapper()
      request_content = self.serialize(request_mapper,  request)
      request_content = request_content != nil ? JSON.generate(request_content, quirks_mode: true) : nil

      path_template = 'v2/publish/{endpointId}'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          path_params: {'endpointId' => endpoint_id},
          body: request_content,
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:post, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end

        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = azure.iiot.opc.publisher::Models::PublishedItemListResponseApiModel.mapper()
            result.body = self.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end

    #
    # Return the service status in the form of the service status
    # api model.
    #
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [StatusResponseApiModel] operation results.
    #
    def get_status(custom_headers:nil)
      response = get_status_async(custom_headers:custom_headers).value!
      response.body unless response.nil?
    end

    #
    # Return the service status in the form of the service status
    # api model.
    #
    # @param custom_headers [Hash{String => String}] A hash of custom headers that
    # will be added to the HTTP request.
    #
    # @return [MsRest::HttpOperationResponse] HTTP response information.
    #
    def get_status_with_http_info(custom_headers:nil)
      get_status_async(custom_headers:custom_headers).value!
    end

    #
    # Return the service status in the form of the service status
    # api model.
    #
    # @param [Hash{String => String}] A hash of custom headers that will be added
    # to the HTTP request.
    #
    # @return [Concurrent::Promise] Promise object which holds the HTTP response.
    #
    def get_status_async(custom_headers:nil)


      request_headers = {}
      request_headers['Content-Type'] = 'application/json; charset=utf-8'
      path_template = 'v2/status'

      request_url = @base_url || self.base_url

      options = {
          middlewares: [[MsRest::RetryPolicyMiddleware, times: 3, retry: 0.02], [:cookie_jar]],
          headers: request_headers.merge(custom_headers || {}),
          base_url: request_url
      }
      promise = self.make_request_async(:get, path_template, options)

      promise = promise.then do |result|
        http_response = result.response
        status_code = http_response.status
        response_content = http_response.body
        unless status_code == 200
          error_model = JSON.load(response_content)
          fail MsRest::HttpOperationError.new(result.request, http_response, error_model)
        end

        # Deserialize Response
        if status_code == 200
          begin
            parsed_response = response_content.to_s.empty? ? nil : JSON.load(response_content)
            result_mapper = azure.iiot.opc.publisher::Models::StatusResponseApiModel.mapper()
            result.body = self.deserialize(result_mapper, parsed_response)
          rescue Exception => e
            fail MsRest::DeserializationError.new('Error occurred in deserializing the response', e.message, e.backtrace, result)
          end
        end

        result
      end

      promise.execute
    end


    private
    #
    # Adds telemetry information.
    #
    def add_telemetry
        sdk_information = 'swagger'
        add_user_agent_information(sdk_information)
    end
  end
end