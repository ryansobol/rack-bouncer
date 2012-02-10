require "test_helper"

class Rack::Bouncer::GoogleCrawlersTest < MiniTest::Unit::TestCase
  def test_allows_googlebot
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:googlebot])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_googlebot_news
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:googlebot_news])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_googlebot_images
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:googlebot_images])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_googlebot_video
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:googlebot_video])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_googlebot_mobile
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:googlebot_mobile])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_google_mobile_adsense
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:google_mobile_adsense])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_google_adsense
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:google_adsense])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_google_adsbot
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:google_adsbot])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
