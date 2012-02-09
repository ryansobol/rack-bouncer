require "test_helper"

class Rack::Bouncer::AOLTest < MiniTest::Unit::TestCase
  def test_expels_aol_l4me
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_l4me])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_6_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_7_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_7_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_8_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_8_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_9_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_9_1])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_5
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_9_5])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_6
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_9_6])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end
end
