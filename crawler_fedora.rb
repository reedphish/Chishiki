require "nokogiri"
require "open-uri"
require "json"

indexes = {
	"Fedora 7" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/7/Fedora/x86_64/os/Fedora/",
	"Fedora 8" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/8/Fedora/x86_64/os/Packages/",
	"Fedora 9" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/9/Fedora/x86_64/os/Packages/",
	"Fedora 10" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/10/Fedora/x86_64/os/Packages/",
	"Fedora 11" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/11/Fedora/x86_64/os/Packages/",
	"Fedora 12" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/12/Fedora/x86_64/os/Packages/",
	"Fedora 13" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/13/Fedora/x86_64/os/Packages/",
	"Fedora 14" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/14/Fedora/x86_64/os/Packages/",
	"Fedora 15" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/15/Fedora/x86_64/os/Packages/",
	"Fedora 16" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Fedora/x86_64/os/Packages/"
}


indexes.each do |releasename, address|
	puts("Processing #{releasename}")
	structure = []

	document = Nokogiri::HTML(open(address))
	document.xpath("//a/text()").each do |packagename|
		if packagename.to_s.end_with?(".rpm")
			structure << packagename
		else
			next
		end
	end

	File.write("./Datastorage/Linux/Fedora/#{releasename}-packages-index.json", structure.to_json)
end