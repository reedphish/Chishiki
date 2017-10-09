require "elasticsearch"
require "json"

elclient = Elasticsearch::Client.new

Dir::glob("./Datastorage/*/*/*.json") do | indexfile |
	elclient.index index: 'chishiki', type: 'softwarelist', body: JSON.parse(File.read(indexfile))
	elclient.indices.refresh index: 'chishiki'
end