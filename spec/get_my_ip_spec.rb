require 'rubygems'
require 'spec'
require 'lib/get_my_ip'

describe GetMyIP do
  
  before(:all) do
    @get_my_ip = GetMyIP.new
  end
  
  it "should get an IP from the given page" do
    ip = @get_my_ip.get_my_external_ip_from("spec/test_files/site_test.html")
    ip.should eql("182.093.186.123")
  end
  
  it "should update the 'ip.txt' file" do
    @get_my_ip.update_file("123.456.789.10")
    file = File.open("lib/ip.txt")
    last_ip = file.readline.strip
    file.close
    last_ip.should eql("123.456.789.10")
  end
  
  it "should get an IP from the given page even if the ip is the same as before" do
    @get_my_ip.update_file("182.093.186.123")
    ip = @get_my_ip.get_my_external_ip(true, "spec/test_files/site_test.html")
    ip.should eql("spec/test_files/site_test.html: 182.093.186.123\n")
  end
  
  it "should not get and IP from the given page if the ip is the same as before" do
    ip = @get_my_ip.get_my_external_ip(false, "spec/test_files/site_test.html")
    ip.should be_nil
  end
end