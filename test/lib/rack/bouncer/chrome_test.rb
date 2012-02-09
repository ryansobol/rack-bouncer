require "test_helper"

class Rack::Bouncer::ChromeTest < MiniTest::Unit::TestCase
  def test_allows_chrome_16
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:chrome_16])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
