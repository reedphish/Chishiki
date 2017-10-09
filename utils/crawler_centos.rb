require "nokogiri"
require "open-uri"
require "./kernel/models/ossoftware"

indexes = {
	"CentOS 2.1" => "http://vault.centos.org/2.1/final/i386/CentOS/RPMS/",
	"CentOS 3.1" => "http://vault.centos.org/3.1/os/x86_64/RedHat/RPMS/",
	"CentOS 3.3" => "http://vault.centos.org/3.3/os/x86_64/RedHat/RPMS/",
	"CentOS 3.4" => "http://vault.centos.org/3.4/os/x86_64/RedHat/RPMS/",
	"CentOS 3.5" => "http://vault.centos.org/3.5/os/x86_64/RedHat/RPMS/",
	"CentOS 3.6" => "http://vault.centos.org/3.6/os/x86_64/RedHat/RPMS/",	
	"CentOS 3.7" => "http://vault.centos.org/3.7/os/x86_64/RedHat/RPMS/",	
	"CentOS 3.8" => "http://vault.centos.org/3.8/os/x86_64/RedHat/RPMS/",	
	"CentOS 3.9" => "http://vault.centos.org/3.9/os/x86_64/RedHat/RPMS/",	
	"CentOS 4.0" => "http://vault.centos.org/4.0/os/x86_64/CentOS/RPMS/",
	"CentOS 4.0beta" => "http://vault.centos.org/4.0beta/os/SRPMS/",
	"CentOS 4.1" => "http://vault.centos.org/4.1/os/SRPMS/",
	"CentOS 4.2" => "http://vault.centos.org/4.2/os/SRPMS/",
	"CentOS 4.2beta" => "http://vault.centos.org/4.2beta/os/SRPMS/",
	"CentOS 4.3" => "http://vault.centos.org/4.3/os/SRPMS/",
	"CentOS 4.4" => "http://vault.centos.org/4.4/os/SRPMS/",
	"CentOS 4.5" => "http://vault.centos.org/4.5/os/SRPMS/",
	"CentOS 4.6" => "http://vault.centos.org/4.6/os/SRPMS/",
	"CentOS 4.7" => "http://vault.centos.org/4.7/os/SRPMS/",
	"CentOS 4.8" => "http://vault.centos.org/4.8/os/SRPMS/",
	"CentOS 4.9" => "http://vault.centos.org/4.9/os/SRPMS/",
	"CentOS 5.0" => "http://vault.centos.org/5.0/os/x86_64/CentOS/",
	"CentOS 5.1" => "http://vault.centos.org/5.1/os/x86_64/CentOS/",
	"CentOS 5.2" => "http://vault.centos.org/5.2/os/x86_64/CentOS/",
	"CentOS 5.3" => "http://vault.centos.org/5.3/os/x86_64/CentOS/",
	"CentOS 5.4" => "http://vault.centos.org/5.4/os/x86_64/CentOS/",
	"CentOS 5.5" => "http://vault.centos.org/5.5/os/x86_64/CentOS/",
	"CentOS 5.6" => "http://vault.centos.org/5.6/os/x86_64/CentOS/",
	"CentOS 5.7" => "http://vault.centos.org/5.7/os/x86_64/CentOS/",
	"CentOS 5.8" => "http://vault.centos.org/5.8/os/x86_64/CentOS/",
	"CentOS 5.9" => "http://vault.centos.org/5.9/os/x86_64/CentOS/",
	"CentOS 5.10" => "http://vault.centos.org/5.10/os/x86_64/CentOS/",
	"CentOS 5.11" => "http://vault.centos.org/5.11/os/SRPMS/",
	"CentOS 6.0" => "http://vault.centos.org/6.0/os/x86_64/Packages/",
	"CentOS 6.1" => "http://vault.centos.org/6.1/os/x86_64/Packages/",
	"CentOS 6.2" => "http://vault.centos.org/6.2/os/x86_64/Packages/",
	"CentOS 6.3" => "http://vault.centos.org/6.3/os/x86_64/Packages/",
	"CentOS 6.4" => "http://vault.centos.org/6.4/os/x86_64/Packages/",
	"CentOS 6.5" => "http://vault.centos.org/6.5/os/x86_64/Packages/",
	"CentOS 6.6" => "http://vault.centos.org/6.6/os/x86_64/Packages/",
	"CentOS 6.7" => "http://vault.centos.org/6.7/os/x86_64/Packages/",
	"CentOS 6.8" => "http://vault.centos.org/6.8/os/Source/SPackages/",
	"CentOS 7.0.1406" => "http://vault.centos.org/7.0.1406/os/x86_64/Packages/",
	"CentOS 7.1.1503" => "http://vault.centos.org/7.1.1503/os/x86_64/Packages/",
	"CentOS 7.2.1511" => "http://vault.centos.org/7.2.1511/os/Source/SPackages/"
}


indexes.each do |releasename, address|
	puts("Processing #{releasename}")
	model = Chishiki::Models::OSSoftware.new
	model.osname = "Linux"
	model.release = releasename
	model.addsource(address)

	document = Nokogiri::HTML(open(address))
	document.xpath("//a/text()").each do |packagename|
		if packagename.to_s.end_with?(".rpm")
			model.addsoftware(packagename)
		else
			next
		end
	end

	File.write("./Datastorage/Linux/CentOS/#{releasename}-packages-index.json", model.to_json)
end