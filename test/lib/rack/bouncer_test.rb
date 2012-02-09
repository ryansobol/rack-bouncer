# encoding: UTF-8
require "test_helper"

class Rack::BouncerTest < MiniTest::Unit::TestCase
  def test_version
    assert_equal "1.3.1", Rack::Bouncer::VERSION
  end

  def test_default_safe_paths
    expected = ["/asset", "/images", "/stylesheets", "/javascripts", "/feedback"]
    assert_equal expected, Rack::Bouncer::DEFAULT_OPTIONS[:safe_paths]
  end

  def test_default_redirect
    assert_equal "http://browsehappy.com/", Rack::Bouncer::DEFAULT_OPTIONS[:redirect]
  end

  def test_default_minimum_ie
    assert_equal 8.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_ie]
  end

  def test_default_minimum_firefox
    assert_equal 4.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_firefox]
  end

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

  # Safe Paths
  #################################################################################################

  def test_allows_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/browser", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_non_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/wrong", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 302, response.status
    assert_equal response.location, "/browser"
  end

  def test_allows_assets_path
    request  = create_request
    response = request.get("/asset", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_images_path
    request  = create_request
    response = request.get("/images", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_stylesheets_path
    request  = create_request
    response = request.get("/stylesheets", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_javascripts_path
    request  = create_request
    response = request.get("/javascripts", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_feedback_path
    request  = create_request
    response = request.get("/feedback", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
