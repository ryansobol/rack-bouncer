require "test_helper"

class Rack::Bouncer::ChromeTest < MiniTest::Unit::TestCase
  def test_allows_chrome_l4me
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_l4me])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_chrome_6_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_6_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_chrome_6_0_when_minimum
    request  = create_request(:minimum_chrome => 6.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_6_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_7_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_7_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_8_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_8_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_9_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_9_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_10_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_10_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_11_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_11_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_12_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_12_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_13_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_13_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_14_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_14_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_15_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_15_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_16_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_16_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_chrome_17_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_17_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
