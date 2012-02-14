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
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel ."
    query += "?concept <http://www.w3.org/2004/02/skos/core#altLabel> ?altLabel ."
    query += "FILTER regex(?prefLabel, '" + @game.capitalize + "')}"
    
    @tQuery = query
    
    endpoint = 'http://157.169.101.31:8080/sparql/'
 
    store = FourStore::Store.new endpoint
    @words = store.select(query)
    print @words
  end
  
end
