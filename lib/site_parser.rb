class SiteParser
  def ip(opened_site)
    myIp = nil
    opened_site.each do |line|
      if /(([0-9]{1,3}\.){3}[0-9]{1,3})/.match(line)
        myIp = $1
      end
    end
    return myIp
  end
end