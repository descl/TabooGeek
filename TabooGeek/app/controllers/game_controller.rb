require 'rubygems'
require 'rest_client'
require 'nokogiri'


class GameController < ApplicationController
  def game
    @game = params[:q]
    
    
    
    query = 'SELECT  ?thing ?a ?type WHERE { ?thing ?a ?type . } ORDER BY ?type'
    endpoint = 'http://localhost:8080/sparql/'
    response = RestClient.post endpoint, :query => query
    @xml = Nokogiri::XML(response.to_str)
    
    
  end
  
end
