require 'open-uri'

class GetMyIP
  
  def initialize
    file = File.open("ip.txt")
    @last_ip = file.readline.strip
    file.close
  end
  def get_my_external_ip(send_anyway)
    this_site = "http://meuip.datahouse.com.br/"
    myIp = get_my_external_ip_from this_site
    if(myIp and (send_anyway or !(myIp == @last_ip)))
      update_file(myIp)
      return "#{this_site}: #{myIp}\n"
    end
    return nil
  end
  
  private
  def get_my_external_ip_from(site)
    myIp = nil
    open(site) do |f|
      f.each do |line|
        if /(([1-9]{1,3}\.){3}[1-9]{1,3})/.match(line)
          myIp = $1
        end
      end
    end
    myIp
  end
  
  def update_file(myIp)
    file = File.open("ip.txt", "w")
    file.puts(myIp)
    file.close
  end
end
  
