require "rubygems"
require "bundler/setup"
require "./kernel/webserver"

Kernel::WebServer.run!
