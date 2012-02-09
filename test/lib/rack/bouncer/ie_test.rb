require "test_helper"

class Rack::Bouncer::IETest < MiniTest::Unit::TestCase
  def test_allows_ie_if_no_version_available
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_no_version])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_ie_6_and_redirects_to_default
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_ie_6_and_redirects_to_internal_url
    request  = create_request(:redirect => "/foo")
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 302, response.status
    assert_equal response.location, "/foo"
  end

  def test_expels_ie_6_and_redirects_to_external_url
    request  = create_request(:redirect => "http://getfirefox.com")
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 302, response.status
    assert_equal response.location, "http://getfirefox.com"
  end

  def test_allows_ie_6_when_minimum
    request  = create_request(:minimum_ie => 6.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_ie_7
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_7])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_ie_7_when_minimum
    request  = create_request(:minimum_ie => 7.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_7])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_8])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8_when_minimum
    request  = create_request(:minimum_ie => 8.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_8])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_9
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_9])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
