require "json"

module Chishiki
	module Models
		class OSSoftware
			attr_accessor :osname
			attr_accessor :release
			attr_reader :source
			attr_reader :software

			def initialize
				@osname = nil,
				@release = nil,
				@source = []
				@software = []
			end

			def addsource(url)
				@source << url
			end

			def addsoftware(name)
				@software << name
			end

			def to_json
				{
					"osname" => @osname,
					"release" => @release,
					"source" => @source,
					"software" => @software
				}.to_json
			end
		end
	end
end