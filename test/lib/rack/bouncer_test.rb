# encoding: UTF-8
require "test_helper"

class Rack::BouncerTest < MiniTest::Unit::TestCase
  def test_version
    assert_equal "1.4.2", Rack::Bouncer::VERSION
  end

  # Default Options
  #################################################################################################

  def test_default_safe_paths
    assert_equal [], Rack::Bouncer::DEFAULT_OPTIONS[:safe_paths]
  end

  def test_default_redirect
    assert_equal "http://browsehappy.com/", Rack::Bouncer::DEFAULT_OPTIONS[:redirect]
  end

  def test_default_minimum_chrome
    assert_equal 7.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_chrome]
  end

  def test_default_minimum_firefox
    assert_equal 4.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_firefox]
  end

  def test_default_minimum_ie
    assert_equal 8.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_ie]
  end

  def test_default_minimum_safari
    assert_equal 4.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_safari]
  end

  # Edge Cases
  #################################################################################################

  def test_allows_if_no_user_agent_specified
    request  = create_request
    response = request.get("/")
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_if_mozilla_non_specific
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:mozilla_non_specific])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # :redirect
  #################################################################################################

  def test_redirects_to_default
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_redirects_to_internal_url
    request  = create_request(:redirect => "/foo")
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "/foo"
  end

  def test_redirects_to_external_url
    request  = create_request(:redirect => "https://www.google.com/chrome")
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "https://www.google.com/chrome"
  end

  # :safe_paths
  #################################################################################################

  def test_allows_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/browser", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_non_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/wrong", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "/browser"
  end

  def test_allows_given_1_safe_path
    request  = create_request(:safe_paths => ["/assets"])
    response = request.get("/assets", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_given_2_safe_paths
    request  = create_request(:safe_paths => ["/assets", "/feedback.html"])
    response = request.get("/feedback.html", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
