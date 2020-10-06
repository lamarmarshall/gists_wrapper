# TODO: Write documentation for `Gists`
require "http/client"
require "json"

module Gists
  VERSION = "0.1.0"
	extend self

	# url to github `API_URL`
	API_URL = "https://api.github.com"
	# host url without protocol
	HOST = "api.github.com"
	#your private or OAuth token from github
	TOKEN = "a47a8b26a1ea80a751ea5aea2c1cc880fe28130f"
  
  #helper function that accepts the ACTION of the api
  # Gists.fetch gists/:id
  #
  def fetch(suffix : String)
  
	url : String =  "#{API_URL}/#{suffix}"
	hd = HTTP::Headers{"Accept" => "text/json", "Authorization" => "token #{TOKEN}"}
	
	response = HTTP::Client.get( url , headers: hd)
	return response.body
		
					  	
  end

# gets all public gists from a user
# function can be used without TOKEN
#
 def pubilc_gists(username : String)

		fetch("users/#{username}/gists")
 end

 #
 # by_id(gist_id)
 # => json response of all properties of the gists
 def by_id(id)
	fetch("gists/#{id}")
 end

 #
 # gets all of the files of a gists id
 #
 def get_files(gist_id)
	r = fetch("gists/#{gist_id}")
	js = JSON.parse r
	js["files"]
 end
 
end

test_id = "026373c659caf1c88a519eaefa3a42e1"
private_id = "8475fd7fde2fcfbff28bcfee7982349f"
#p Gists.fetch("users/lamarmarshall/gists")
#p Gists.pubilc_gists("lamarmarshall")
#pp Gists.by_id(private_id)
pp Gists.get_files(private_id)