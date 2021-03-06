require 'rubygems'
require 'spec'
require File.dirname(__FILE__) + "/../lib/site_parser.rb"
require File.dirname(__FILE__) + "/doubles/io_stub"

describe SiteParser do
  it "should find my IP from the site" do
    opened_site = IOStub.new
    site_parser = SiteParser.new
    ip = site_parser.ip(opened_site)
    ip.should eql("127.0.0.1")
  end
  
end