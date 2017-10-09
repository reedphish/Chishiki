require "rubygems"
require "bundler/setup"
require "./Kernel/webserver"

Kernel::WebServer.run!
