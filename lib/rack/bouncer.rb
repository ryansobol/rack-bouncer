# encoding: UTF-8

module Rack
  class Bouncer
    VERSION = "1.2"

    def initialize(app, options = {})
      @app = app
      @options = options
      @options[:redirect] ||= "http://browsehappy.com/"
      @options[:minimum] ||= 8.0
    end

    def call(env)
      if ie6_found_in?(env) || aol_found_in?(env)
        kick_it
      else
        @app.call(env)
      end
    end

    private

    def ie6_found_in?(env)
      if env["HTTP_USER_AGENT"]
        is_ie?(env["HTTP_USER_AGENT"]) and ie_version(env["HTTP_USER_AGENT"]) < @options[:minimum] and @options[:redirect] != env["PATH_INFO"]
      end
    end

    def is_ie?(ua_string)
      # We need at least one digit to be able to get the version, hence the \d
      ua_string.match(/MSIE \d/) ? true : false
    end

    def aol_found_in?(env)
      if env["HTTP_USER_AGENT"]
        is_aol?(env["HTTP_USER_AGENT"])
      end
    end

    def is_aol?(ua_string)
      ua_string.match(/AOL \d/) ? true : false
    end

    def ie_version(ua_string)
      ua_string.match(/MSIE (\S+)/)[1].to_f
    end

    def kick_it
      [302, {"Location" => @options[:redirect], "Content-Type" => "text/html"}, "Browser not supported"]
    end
  end
end