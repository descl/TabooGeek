require 'rubygems'
require 'rest_client'
require 'nokogiri'


class GameController < ApplicationController
  def game
    @game = params[:q]
    
    
    
    #query = 'SELECT ?thing ?a ?type WHERE { ?thing ?a ?type }'
    
    query =  'PREFIX skos: <http://www.w3.org/2004/02/skos/core#>'
    query += 'SELECT ?altLabel WHERE {'
    query += '?concept skos:prefLabel ?prefLabel' 
    query += '?concept skos:altLabel ?altLabel'
    query += 'FILTER regex(?prefLabel, "' + @game.capitalize + '")}'
    
    endpoint = 'http://157.169.101.31:8080/sparql/'
    response = RestClient.post endpoint, :query => query
    @xml = Nokogiri::XML(response.to_str)
    
    
  end
  
end
