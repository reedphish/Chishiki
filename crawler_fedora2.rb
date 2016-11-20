require "nokogiri"
require "open-uri"
require "json"

indexes = {
	"Fedora 17" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/17/Fedora/x86_64/os/Packages/",
	"Fedora 18" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/18/Fedora/x86_64/os/Packages/",
	"Fedora 19" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/19/Fedora/x86_64/os/Packages/",
	"Fedora 20" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Fedora/x86_64/os/Packages/",
	"Fedora 21" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/21/Everything/x86_64/os/Packages/",
	"Fedora 22" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/22/Everything/x86_64/os/Packages/"
}

indexes.each do |releasename, address|
	puts("Processing #{releasename}")
	structure = []

	("a".."z").each do | letter |
		url = "#{address}/#{letter}/"

		document = Nokogiri::HTML(open(url))

		document.xpath("//a/text()").each do | packagename |
			if packagename.to_s.end_with?(".rpm")
				structure << packagename
			else
				next
			end
		end
	end

	File.write("./Datastorage/Linux/Fedora/#{releasename}-packages-index.json", structure.to_json)
end