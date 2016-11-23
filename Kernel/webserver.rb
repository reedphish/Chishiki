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
   end
end