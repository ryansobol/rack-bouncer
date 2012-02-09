require "test_helper"

class Rack::Bouncer::SafariTest < MiniTest::Unit::TestCase
  def test_allows_safari_5_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
