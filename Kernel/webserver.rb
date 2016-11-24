require "rubygems"
require "bundler/setup"
require "sinatra"
require "json"

module Kernel
  class WebServer < Sinatra::Base
      set :public_folder, "Public"

      get "/" do
        erb :index
      end

      post "/rest/search" do
      	content_type :json
  		{ :query => params[:query] }.to_json
      end
   end
end