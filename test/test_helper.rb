# encoding: UTF-8
require "rubygems"
require "minitest/autorun"
require "rack/mock"
require "yaml"

require "rack-bouncer"

USER_AGENTS = YAML.load_file(File.expand_path("user_agents.yml", File.dirname(__FILE__)))

class TestApp
  def call(env)
    [200, {}, "Hi Internets!"]
  end
end

def create_request(options = {})
  Rack::MockRequest.new(Rack::Bouncer.new(TestApp.new, options))
end
