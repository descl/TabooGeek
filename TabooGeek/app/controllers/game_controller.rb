require 'rubygems'
require 'rest_client'
require 'nokogiri'
require '4store-ruby'

class GameController < ApplicationController
  def game
    endpoint = 'http://zouig.org:8081/sparql/'
    endpointUpdate = 'http://zouig.org:8081/update/'
    
    
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?prefLabel WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel }"
    store = FourStore::Store.new endpoint
    @wordsCount = store.select(query).length
    
    @word = params[:word]
    
    
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?prefLabel ?concept ?altLabel ?element ?weight WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel ."
    query += "?concept <http://TabooGeek.zouig.org/TabooGeek-schema#element> ?element ."
    query += "?element <http://www.w3.org/2004/02/skos/core#altLabel> ?altLabel ."
    query += "?element <http://TabooGeek.zouig.org/TabooGeek-schema#weight> ?weight ."
    query += "FILTER regex(?prefLabel, '" + @word.capitalize + "')} ORDER BY DESC(?weight) LIMIT 5"
    
    @words = store.select(query)
    
    indice = params[:indice]
    if indice != nil
      indice = indice.downcase
      #First we search if the item is already in database
      query2 =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
      query2 += "SELECT ?altLabel ?element ?weight WHERE {\n"
      query2 += "<" + @words[0]['concept'] + "> <http://TabooGeek.zouig.org/TabooGeek-schema#element> ?element ."
      query2 += "?element <http://www.w3.org/2004/02/skos/core#altLabel> ?altLabel ."
      query2 += "?element <http://TabooGeek.zouig.org/TabooGeek-schema#weight> ?weight ."
      query2 += "FILTER regex(?altLabel, '" + indice + "')}"
      
      response = store.select(query2)
      print(query2)
      print(response)
      if response != nil && response.length >0
        #word is in batabase
        score = String(Integer(response[0]['weight']) + 1)
        
        
        
        delete = "DELETE {"
        delete+= "?element <http://www.w3.org/2004/02/skos/core#altLabel> \"" + indice + "\"."
        delete+= "} WHERE { "
        delete+= "<" + @words[0]['concept'] + "> <http://TabooGeek.zouig.org/TabooGeek-schema#element> ?element"
        delete+= "}"
        RestClient.post endpointUpdate, :update => delete
        
        response = store.add('http://tabooGeek.zouig.org/#NewRelations', "
          <"+@words[0]['concept']+"> <http://TabooGeek.zouig.org/TabooGeek-schema#element> _:a .
          _:a <http://www.w3.org/2004/02/skos/core#altLabel> \"" + indice + "\".
          _:a <http://TabooGeek.zouig.org/TabooGeek-schema#weight> \"" + score + "\" .");      
        
      else
        response = store.add('http://tabooGeek.zouig.org/#NewRelations', "
          <"+@words[0]['concept']+"> <http://TabooGeek.zouig.org/TabooGeek-schema#element> _:a .
          _:a <http://www.w3.org/2004/02/skos/core#altLabel> \"" + indice + "\".
          _:a <http://TabooGeek.zouig.org/TabooGeek-schema#weight> \"1\" ."); 
      end
      @words = store.select(query)
      puts response
    end
  end
end
