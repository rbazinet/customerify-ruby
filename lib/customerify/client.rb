require 'httparty'

module Customerify
  class Client
    include HTTParty
    base_uri 'http://customerify.dev'

    class MissingIdAttributeError < RuntimeError; end
    class InvalidResponse < RuntimeError; end

    def initialize(account_identifier, api_key)
      @auth = { "X-AccountIdentifier" => account_identifier, "X-APIKey" => api_key }
    end

    def identify(attributes)
      create_or_update(attributes)
    end

    def track(*args)
      attributes = extract_attributes(args)

      if args.length == 1
        event_descriptor = args.first
        create_anonymous_event(event_descriptor, attributes)
      else
        # Passed in a customer id and an event name.
        # Track the event for the given customer
        event_descriptor = args
        create_account_event(event_descriptor, attributes)
      end
    end

    private

    def create_event_transaction(url, event_descriptor, attributes = {})
      body = { :event_descriptor => event_descriptor, :data => attributes }
      body[:timestamp] = attributes[:timestamp] if valid_timestamp?(attributes[:timestamp])
      verify_response(self.class.post(url, options.merge(:body => body)))
    end

    def create_or_update(attributes = {})
      raise MissingIdAttributeError.new("Must provide a customer id") unless attributes[:id]
      url = customer_path(attributes[:id])
      verify_response(self.class.put(url, options.merge(:body => attributes)))
    end

    def create_account_event(event_descriptor, attributes = {})
      create_event_transaction("/api/event_transactions", event_descriptor, attributes)
    end

    def create_anonymous_event(event_descriptor, attributes = {})
      create_event_transaction("/api/event_transactions", event_descriptor, attributes)
    end

    def event_transaction_path
      "/api/event_transactions"
    end

    def valid_timestamp?(timestamp)
      timestamp && timestamp.is_a?(Integer) && timestamp > 999999999 && timestamp < 100000000000
    end

    def verify_response(response)
      if response.code >= 200 && response.code < 300
        response
      else
        raise InvalidResponse.new("Customerify API returned a bad response: #{response.code}")
      end
    end

    def extract_attributes(args)
      hash = args.last.is_a?(Hash) ? args.pop : {}
      hash.inject({}){ |hash, (k,v)| hash[k.to_sym] = v; hash }
    end

    def options
      { :headers => @auth }
    end

  end
end
