require 'get_my_ip'
require 'notifier'


class IPChangedNotifier
  def initialize()
    @send_anyway = true
    ARGV.each do |argument|
      @email = argument if argument =~ /^.*@.*\..*$/
      @send_anyway = false if argument =~ /^-r$/
    end
    raise Exception.new("need email") if @email == nil
  end
  
  def run
    send_message()
  end
  
  private
  def send_message()
    ip = GetMyIP.new
    my_ip = ip.get_my_external_ip @send_anyway
    if(my_ip)
      sub = "Seu IP"
      from = "mudou.ip@gmail.com"
      send = Notifier.new
      send.get_value(@email,my_ip,sub,from)
      puts "enviou"
    end
  end
  
    
end

app = IPChangedNotifier.new
app.run
