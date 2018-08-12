require 'open-uri'

class PagesController < ApplicationController
  include PagesHelper

  before_action :load_example_urls, only: [:home]
  before_action :load_resource, only: [:home]

  def home
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def parse_for_cached_endpoint(endpoint)
    if cached_endpoint = SWAPI_CACHED_ENDPOINT_REGEX.match(endpoint)
      klass = case cached_endpoint[1]
              when "people"
                Person
              when "planets"
                Planet
              end

      {
        klass: klass,
        swapi_id: cached_endpoint[2]
      }
    end
  end

  def load_resource_from_db(klass, swapi_id, endpoint)
    if obj = klass.find_by(swapi_id: swapi_id)
      attributes = obj.to_h
    else
      attributes = load_resource_from_api(endpoint)
      obj = klass.new(swapi_id: swapi_id)
      obj.attributes = attributes

      if obj.save
        attributes = obj.to_h
      else
        # TODO: report the error to a service like Rollbar so an admin
        #       can debug further; we'll fallback to the JSON response
      end
    end

    attributes
  end

  def load_resource_from_api(endpoint)
    response = JSON.load(open("#{SWAPI_BASE_URL}#{endpoint}"))
  rescue => e
    response = { error: e }
  end

  def load_resource
    @endpoint = params[:endpoint].to_s
    @endpoint = "/#{@endpoint}" unless @endpoint.start_with?('/')

    if SWAPI_CACHE_ENABLED && cached_endpoint = parse_for_cached_endpoint(@endpoint)
      @response = load_resource_from_db(
        cached_endpoint[:klass], cached_endpoint[:swapi_id], @endpoint)
    else
      @response = load_resource_from_api(@endpoint)
    end

    @response = linkify(@response)
  end

  def load_example_urls
    @example_urls = %w(/people/1/ /planets/3/ /starships/9/)
  end

  def linkify(response)
    response.each do |key, value|
      response[key] = case value
                      when Array
                        if value[0].is_a?(String)
                          value.map { |url| swapi_data_parser(url) }
                        else
                          value.map { |obj| linkify(obj) }
                        end
                      when String
                        swapi_data_parser(value.to_s)
                      else
                        value
                      end
    end
  end
end
