require "test_helper"

class Rack::Bouncer::YahooCrawlersTest < MiniTest::Unit::TestCase
  def test_allows_yahoo_slurp
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:yahoo_slurp])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_yahoo_slurp_china
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:yahoo_slurp_china])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
