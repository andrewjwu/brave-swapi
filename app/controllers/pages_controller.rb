require 'open-uri'

class PagesController < ApplicationController
  SWAPI_BASE_URL = "https://swapi.co/api"

  def home
    if endpoint = params[:endpoint]
      endpoint = "/#{endpoint}" unless endpoint.start_with?('/')

      begin
        @response = JSON.load(open("#{SWAPI_BASE_URL}#{endpoint}"))
      rescue => e
        @response = { error: e }
      end
    end

    respond_to do |format|
      format.js
      format.html
    end
  end
end
