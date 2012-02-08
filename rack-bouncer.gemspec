# encoding: UTF-8
require File.expand_path("lib/rack/bouncer", File.dirname(__FILE__))

Gem::Specification.new do |s|
  s.name        = "rack-bouncer"
  s.version     = Rack::Bouncer::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jerod Santo", "Julio Cesar Ody", "Will Jessop", "Ryan Sobol"]
  s.email       = "contact@ryansobol.com"
  s.homepage    = "https://github.com/ryansobol/rack-bouncer"
  s.summary     = "A Rack middleware to expel undesirable browsers out of your website."
  s.description = "A Rack middleware to expel undesirable browsers out of your website."

  s.required_ruby_version     = "~> 1.8.7"
  s.required_rubygems_version = ">= 1.3.7"
  s.rubyforge_project         = "rack-bouncer"

  s.add_development_dependency "minitest",  "~> 2.11.1"
  s.add_development_dependency "rack",      "~> 1.4.1"

  s.files              = `git ls-files`.split("\n")
  s.test_files         = `git ls-files -- spec/*`.split("\n")
  s.require_paths      = ["lib"]
end