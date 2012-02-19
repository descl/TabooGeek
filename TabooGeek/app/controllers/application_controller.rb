class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    query =  "PREFIX skos: <http://www.w3.org/2004/02/skos/core#>\n"
    query += "SELECT COUNT(?concept) as count WHERE {\n"
    query += "?concept <http://www.w3.org/2004/02/skos/core#prefLabel> _:prefLabel\n}"
    
    endpoint = 'http://zouig.org:8081/sparql/'
 
    store = FourStore::Store.new 'http://zouig.org:8081/sparql/'
    @nbWords = store.select(query)
  end
end
