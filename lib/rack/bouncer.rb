# encoding: UTF-8

module Rack
  class Bouncer
    VERSION = "1.4.1"

    DEFAULT_OPTIONS = {
      :safe_paths      => [],
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
      path_info  = env["PATH_INFO"]
      user_agent = env["HTTP_USER_AGENT"]

      return @app.call(env) if safe_path?(path_info) || user_agent_blank?(user_agent)

      return expel if undesirable_ie?(user_agent)      ||
                      undesirable_aol?(user_agent)     ||
                      undesirable_firefox?(user_agent) ||
                      undesirable_safari?(user_agent)  ||
                      undesirable_chrome?(user_agent)

      @app.call(env)
    end

    private

    def safe_path?(path_info)
      return true if path_info == @options[:redirect]

      return false if @options[:safe_paths].empty?
      return path_info =~ Regexp.new("^(#{@options[:safe_paths].join("|")})")
    end

    def user_agent_blank?(user_agent)
      user_agent.nil? || user_agent.empty?
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