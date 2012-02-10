require "test_helper"

class Rack::Bouncer::MicrosoftCrawlersTest < MiniTest::Unit::TestCase
  def test_allows_bingbot
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:bingbot])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
