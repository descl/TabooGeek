require 'rubygems'
require 'rest_client'
require 'nokogiri'
require '4store-ruby'

class GameController < ApplicationController
  def game
    @word = params[:word]
    
    #query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    #query += "SELECT ?altLabel WHERE { ?concept skos:prefLabel ?altLabel }"
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?concept ?altLabel ?element ?test WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel ."
    query += "?concept <http://TabooGeek.zouig.org/TabooGeek-schema#element> ?element ."
    query += "?element <http://www.w3.org/2004/02/skos/core#altLabel> ?altLabel ."
    query += "FILTER regex(?prefLabel, '" + @word.capitalize + "')}"
    
    #@tQuery = query
    
    endpoint = 'http://zouig.org:8081/sparql/'
 
    store = FourStore::Store.new 'http://zouig.org:8081/sparql/'
    @words = store.select(query)
    print @words
    
    indice = params[:indice]
    if indice != nil
      response = store.add('http://tabooGeek.zouig.org/#NewRelations', "
        <"+@words[0]['concept']+"> <http://www.w3.org/2004/02/skos/core#altLabel> \"" + indice + "\".
        "); 

      @words = store.select(query)
      puts response
    end
    
  end
  
end
