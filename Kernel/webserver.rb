require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"
require "elasticsearch"

module Kernel
  class WebServer < Sinatra::Base
      set :public_folder, "Public"

      get "/" do
        erb :index
      end

      post "/rest/search" do
      	elsearch = Elasticsearch::Client.new

      	searchresult = elsearch.search(
      		index: "chishiki", 
      		body: { 
      			query: { 
      				match: { 
      					_all: params[:query]
      				} 
      			}
      		}
      	)

      	content_type :json
  		{ :query => searchresult }.to_json
      end
   end
end