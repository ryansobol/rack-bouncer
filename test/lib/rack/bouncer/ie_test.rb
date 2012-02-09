require "test_helper"

class Rack::Bouncer::IETest < MiniTest::Unit::TestCase
  def test_allows_ie_l4me
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_l4me])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_6_0_when_minimum
    request  = create_request(:minimum_ie => 6.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_ie_7_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_7_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_ie_7_0_b
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_7_0_b])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_ie_7_0_when_minimum
    request  = create_request(:minimum_ie => 7.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_7_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_8_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8_0_when_minimum
    request  = create_request(:minimum_ie => 8.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_8_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_9_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:ie_9_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
