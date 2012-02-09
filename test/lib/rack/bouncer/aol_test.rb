require "test_helper"

class Rack::Bouncer::AOLTest < MiniTest::Unit::TestCase
  def test_expels_aol_6
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_6])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_7
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_7])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_8
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_8])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:aol_9])
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
