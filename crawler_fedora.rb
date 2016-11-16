require "nokogiri"
require "open-uri"
require "json"

indexes = {
	"Fedora_7" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/7/Fedora/x86_64/os/Fedora/",
	"Fedora_8" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/8/Fedora/x86_64/os/Packages/",
	"Fedora_9" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/9/Fedora/x86_64/os/Packages/",
	"Fedora_10" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/10/Fedora/x86_64/os/Packages/",
	"Fedora_11" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/11/Fedora/x86_64/os/Packages/",
	"Fedora_12" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/12/Fedora/x86_64/os/Packages/",
	"Fedora_13" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/13/Fedora/x86_64/os/Packages/",
	"Fedora_14" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/14/Fedora/x86_64/os/Packages/",
	"Fedora_15" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/15/Fedora/x86_64/os/Packages/",
	"Fedora_16" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/16/Fedora/x86_64/os/Packages/",
	"Fedora_17" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/17/Fedora/x86_64/os/Packages/",
	"Fedora_18" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/18/Fedora/x86_64/os/Packages/",
	"Fedora_19" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/19/Fedora/x86_64/os/Packages/",
	"Fedora_20" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/20/Fedora/x86_64/os/Packages/",
	"Fedora_21" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/21/Everything/x86_64/os/Packages/",
	"Fedora_22" => "http://archives.fedoraproject.org/pub/archive/fedora/linux/releases/22/Everything/x86_64/os/Packages/",
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

	File.write("./Datastorage/Linux/#{releasename}-packages-index.json", structure.to_json)
end