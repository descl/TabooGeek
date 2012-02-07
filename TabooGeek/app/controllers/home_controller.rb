class HomeController < ApplicationController
  def index
    
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT ?prefLabel WHERE {\n"
    query += "?concept skos:prefLabel ?prefLabel }"
    
    endpoint = 'http://157.169.101.31:8080/sparql/'
    response = RestClient.post endpoint, :query => query
    xml = Nokogiri::XML(response.to_str)
    @words = xml.xpath('//sparql:binding[@name = "prefLabel"]/sparql:literal', 'sparql' => 'http://www.w3.org/2005/sparql-results#')
  end
end
