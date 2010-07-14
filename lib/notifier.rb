require 'rubygems'
require 'action_mailer'
require "net/smtp"
require "tlsmail"

class MailSent < ActionMailer::Base
  def message(r = "", m = "", s = "", f = "", c = nil)
    begin
      fail StandardError, "No Recipient" if r.empty? #and b.empty?
      fail StandardError, "No Message" if m.empty? 
      fail StandardError, "No Subject" if s.empty?
      fail StandardError, "No From" if s.empty?
      from f
      recipients r
      cc c if c and !c.empty?
      subject s
      body m
    rescue Exception => e
      puts e
    end
  end
end

class Notifier
  def get_value(to,msg,sub,from,pass=nil,cc=nil)
    begin

      Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
      ActionMailer::Base.smtp_settings = {
        :address => "smtp.gmail.com",
        :port => "587",
        :domain => "gmail.com",
        :user_name => "mudou.ip",
        :password => "TpnwNcLm@pKPGYUKXTYY",
        :authentication => :plain
      }
      MailSent.deliver_message(to,msg,sub,from,cc)
    rescue Exception=>e
      puts e
    end
  end
end


    