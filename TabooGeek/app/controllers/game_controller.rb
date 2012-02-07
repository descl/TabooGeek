require 'rubygems'
require 'rest_client'
require 'nokogiri'


class GameController < ApplicationController
  def game
    @game = params[:q]
    
    
    
    #query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    #query += "SELECT ?altLabel WHERE { ?concept skos:prefLabel ?altLabel }"
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?altLabel WHERE {\n"
    query += "?concept skos:prefLabel ?prefLabel ."
    query += "?concept skos:altLabel ?altLabel ."
    query += "FILTER regex(?prefLabel, '" + @game.capitalize + "')}"
    
    @tQuery = query
    
    endpoint = 'http://157.169.101.31:8080/sparql/'
    response = RestClient.post endpoint, :query => query
    @xml = Nokogiri::XML(response.to_str)
    @words = @xml.xpath('//sparql:binding[@name = "altLabel"]/sparql:literal', 'sparql' => 'http://www.w3.org/2005/sparql-results#')
    
    
  end
  
end
