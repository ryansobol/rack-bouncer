require "test_helper"

class Rack::Bouncer::FirefoxTest < MiniTest::Unit::TestCase
  def test_allows_firefox_l4me
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_l4me])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_firefox_3_6
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_6])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_firefox_3_6_when_minimum
    request  = create_request(:minimum_firefox => 3.6)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_6])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_firefox_3_6_2
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_6_2])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_6_b5
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_6_b5])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_6_22
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_6_22])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_8
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_3_8])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_firefox_4_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_4_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_4_0_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_4_0_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_5_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_5_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_6_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_9_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_9_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_9_0_a2
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_9_0_a2])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_10_0_a4
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:firefox_10_0_a4])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
