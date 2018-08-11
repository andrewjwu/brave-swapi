require 'open-uri'

class PagesController < ApplicationController
  include PagesHelper

  before_action :load_example_urls

  def home
    if @endpoint = params[:endpoint]
      @endpoint = "/#{@endpoint}" unless @endpoint.start_with?('/')

      begin
        @response = JSON.load(open("#{SWAPI_BASE_URL}#{@endpoint}"))
        @response = linkify(@response)
      rescue => e
        @response = { error: e }
      end
    end

    respond_to do |format|
      format.js
      format.html
    end
  end

  private

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
