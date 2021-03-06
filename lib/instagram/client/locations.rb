module Instagram
  class Client
    # Defines methods related to media items
    module Locations
      # Returns extended information of a given Instagram location
      #
      # @overload location(id)
      #   @param location [Integer] An Instagram location ID
      #   @return [Hashie::Mash] The requested location.
      #   @example Return extended information for the Instagram office
      #     Instagram.location(514276)
      # @format :json
      # @authenticated false
      # @rate_limited true
      # @see TODO:docs url
      def location(id, *args)
        response = get("locations/#{id}")
        response["data"]
      end

      # Returns a list of recent media items for a given Instagram location
      #
      # @overload location_recent_media(id, options={})
      #   @param user [Integer] An Instagram location ID.
      #   @param options [Hash] A customizable set of options.
      #   @option options [Integer] :max_id (nil) Returns results with an ID less than (that is, older than) or equal to the specified ID.
      #   @option options [Integer] :count (nil) Limits the number of results returned per page.
      #   @return [Hashie::Mash]
      #   @example Return a list of the most recent media items taken at the Instagram office
      #     Instagram.location_recent_media(514276)
      # @see TODO:docs url
      # @format :json
      # @authenticated false
      # @rate_limited true
      def location_recent_media(id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("locations/#{id}/media/recent", options)
        response
      end

      # Returns Instagram locations within proximity of given lat,lng or foursquare venue id
      #
      # @param lat [String] A given latitude in decimal format
      # @param lng [String] A given longitude in decimal format
      # or
      # @param foursquare_v2_id [String] A valid Foursquare Venue ID (v2)
      # @option options [Integer] :count The number of media items to retrieve.
      # @return [Array]
      # @example 1: Return a location with the Foursquare Venue ID = ()
      #   Instagram.location_search("")
      # @example 2: Return locations around 37.7808851, -122.3948632 (164 S Park, SF, CA USA)
      #   Instagram.location_search("37.7808851", "-122.3948632")
      # @see TODO:doc url
      # @format :json
      # @authenticated false
      # @rate_limited true
      def location_search(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        case args.size
        when 1
          foursquare_v2_id = args.first
          response = get('locations/search', options.merge(:foursquare_v2_id => foursquare_v2_id))
        when 2
          lat, lng = args
          response = get('locations/search', options.merge(:lat => lat, :lng => lng))
        end
        response["data"]
      end
    end
  end
end
