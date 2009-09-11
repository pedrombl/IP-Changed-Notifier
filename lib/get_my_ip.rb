require 'open-uri'
require File.dirname(__FILE__) + '/site_parser'

class GetMyIP
  
  def initialize
    file = File.open(File.dirname(__FILE__) + "/ip.txt")
    @last_ip = file.readline.strip
    file.close
  end
  
  def get_my_external_ip(send_anyway, this_site)  
    myIp = get_my_external_ip_from this_site
    if(myIp and (send_anyway or !(myIp == @last_ip)))
      update_file(myIp)
      return "#{this_site}: #{myIp}\n"
    end
    return nil
  end

  def get_my_external_ip_from(site)
    myIp = nil
    site_parser = SiteParser.new
    open(site) do |f|
      myIp = site_parser.ip(f)
    end
    myIp
  end
  
  def update_file(myIp)
    file = File.open(File.dirname(__FILE__) + "/ip.txt", "w")
    file.puts(myIp)
    file.close
  end
end
  
