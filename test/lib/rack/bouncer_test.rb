require "rubygems"
require "minitest/autorun"
require "rack/mock"

require File.join(File.dirname(__FILE__), "..", "..", "..", "lib", "rack", "bouncer")

class TestApp
  def call(env)
    [200, {}, "Hi Internets!"]
  end
end

def create_request(options = { :redirect => "http://slashdot.org" })
  Rack::MockRequest.new(Rack::Bouncer.new(TestApp.new, options))
end

class Rack::Bouncer::Test < MiniTest::Unit::TestCase

  def test_redirects_to_where_it_should_if_ie6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "MSIE 6.0" })
    assert_equal 301, response.status
    assert_equal response.location, "http://slashdot.org"
  end

  def test_redirects_to_where_it_should_if_user_specified_minimum_not_met
    request  = create_request(:redirect => "http://slashdot.org", :minimum => 6.0)
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 5.5b1; Mac_PowerPC)" })
    assert_equal 301, response.status
    assert_equal response.location, "http://slashdot.org"
  end

  def test_redirects_to_local_urls
    request  = create_request(:redirect => "/foo")
    response = request.get("/foo", {"HTTP_USER_AGENT" => "MSIE 6.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_if_not_ie6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0"})
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_if_UA_version_greater_than_minimum
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 8.0; Windows XP)"})
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_if_no_UA_version_no_available
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE l4me; Windows XP)"})
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_if_no_user_agent_specified
    request  = create_request
    response = request.get("/")
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

end
