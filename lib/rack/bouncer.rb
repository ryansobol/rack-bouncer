# encoding: UTF-8

module Rack
  class Bouncer
    VERSION = "1.3.0"

    DEFAULT_OPTIONS = {
      :safe_paths      => ["/asset", "/images", "/stylesheets", "/javascripts", "/feedback"],
      :redirect        => "http://browsehappy.com/",
      :minimum_ie      => 8.0,
      :minimum_firefox => 4.0
    }

    def initialize(app, options = {})
      @app     = app
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def call(env)
      return @app.call(env) if safe_path?(env)
      return @app.call(env) if user_agent_blank?(env)

      user_agent = env["HTTP_USER_AGENT"]

      if undesirable_ie_present?(user_agent)  || undesirable_aol_present?(user_agent) || undesirable_firefox_present?(user_agent)
        return kick_it
      end

      @app.call(env)
    end

    private

    def safe_path?(env)
      return true if @options[:redirect] == env["PATH_INFO"]
      return env["PATH_INFO"] =~ Regexp.new("^(#{@options[:safe_paths].join("|")})")
    end

    def user_agent_blank?(env)
      env["HTTP_USER_AGENT"].nil? || env["HTTP_USER_AGENT"].empty?
    end

    def kick_it
      [302, {"Location" => @options[:redirect], "Content-Type" => "text/html"}, "Browser not supported"]
    end

    # Internet Explorer
    ###############################################################################################

    def undesirable_ie_present?(user_agent)
      is_ie?(user_agent) && ie_version(user_agent) < @options[:minimum_ie]
    end

    def is_ie?(user_agent)
      # We need at least one digit to be able to get the version, hence the \d
      user_agent.match(/MSIE \d/) ? true : false
    end

    def ie_version(user_agent)
      user_agent.match(/MSIE (\S+)/)[1].to_f
    end

    # AOL
    ###############################################################################################

    def undesirable_aol_present?(user_agent)
      is_aol?(user_agent)
    end

    def is_aol?(user_agent)
      user_agent.match(/AOL \d/) ? true : false
    end

    # Firefox
    ###############################################################################################

    def undesirable_firefox_present?(user_agent)
      is_firefox?(user_agent) && firefox_version(user_agent) < @options[:minimum_firefox]
    end

    def is_firefox?(user_agent)
      # We need at least one digit to be able to get the version, hence the \d
      user_agent.match(/Firefox\/\d/) ? true : false
    end

    def firefox_version(user_agent)
      user_agent.match(/Firefox\/(\S+)/)[1].to_f
    end
  end
end