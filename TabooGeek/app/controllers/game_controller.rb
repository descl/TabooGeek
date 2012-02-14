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
    query += "SELECT ?concept ?altLabel WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel ."
    query += "?concept <http://www.w3.org/2004/02/skos/core#altLabel> ?altLabel ."
    query += "FILTER regex(?prefLabel, '" + @word.capitalize + "')}"
    
    @tQuery = query
    
    endpoint = 'http://157.169.101.31:8080/sparql/'
 
    store = FourStore::Store.new 'http://157.169.101.31:8080/sparql/'
    @words = store.select(query)
    #print @words
    
    @indice = params[:indice]
    if @indice != nil
      response = store.add('http://tabooGeek.zouig.org/#NewRelations', "
        <"+@words[0]['concept']+"> <http://www.w3.org/2004/02/skos/core#altLabel> \""+@indice+"\".
        "); 

      @words = store.select(query)
      puts response
    end
    
  end
  
end
