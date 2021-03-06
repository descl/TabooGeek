require 'rubygems'
require '4store-ruby'


class HomeController < ApplicationController
  def index
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?prefLabel WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> ?prefLabel }"
    
    endpoint = 'http://zouig.org:8081/sparql/'
    #response = RestClient.post endpoint, :query => query
    #xml = Nokogiri::XML(response.to_str)
    #@words = xml.xpath('//sparql:binding[@name = "prefLabel"]/sparql:literal', 'sparql' => 'http://www.w3.org/2005/sparql-results#')

    store = FourStore::Store.new endpoint
    @words = store.select(query)
    
    @wordsCount = @words.length
    
  end
end
