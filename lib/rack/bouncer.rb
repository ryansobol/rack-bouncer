# encoding: UTF-8

module Rack
  class Bouncer
    VERSION = "1.3.1"

    DEFAULT_OPTIONS = {
      :safe_paths      => ["/asset", "/images", "/stylesheets", "/javascripts", "/feedback"],
      :redirect        => "http://browsehappy.com/",
      :minimum_chrome  => 7.0,
      :minimum_firefox => 4.0,
      :minimum_ie      => 8.0,
      :minimum_safari  => 4.0
    }

    def initialize(app, options = {})
      @app     = app
      @options = DEFAULT_OPTIONS.merge(options)
    end

    def call(env)
      return @app.call(env) if safe_path?(env) || user_agent_blank?(env)

      user_agent = env["HTTP_USER_AGENT"]

      return expel if undesirable_ie?(user_agent)      ||
                      undesirable_aol?(user_agent)     ||
                      undesirable_firefox?(user_agent) ||
                      undesirable_safari?(user_agent)  ||
                      undesirable_chrome?(user_agent)

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

    def expel
      header = { "Location" => @options[:redirect], "Content-Type" => "text/html" }
      [302, header, "User Agent not permitted"]
    end

    def undesirable_ie?(user_agent)
      match = user_agent.match(/MSIE (\S+)/)
      return false if match.nil?

      version = match[1].to_f
      return false if version == 0.0

      version < @options[:minimum_ie]
    end

    def undesirable_aol?(user_agent)
      user_agent.match(/AOL \S+/) ? true : false
    end

    def undesirable_firefox?(user_agent)
      match = user_agent.match(/Firefox\/(\S+)/)
      return false if match.nil?

      version = match[1].to_f
      return false if version == 0.0

      version < @options[:minimum_firefox]
    end

    def undesirable_safari?(user_agent)
      match = user_agent.match(/Version\/(\S+)\s+Safari\/\S+/)
      return false if match.nil?

      version = match[1].to_f
      return false if version == 0.0

      version < @options[:minimum_safari]
    end

    def undesirable_chrome?(user_agent)
      match = user_agent.match(/Chrome\/(\S+)\s+Safari\/\S+/)
      return false if match.nil?

      version = match[1].to_f
      return false if version == 0.0

      version < @options[:minimum_chrome]
    end
  end
end