require "test_helper"

class Rack::Bouncer::SafariTest < MiniTest::Unit::TestCase
  def test_allows_safari_l4me
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_l4me])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_safari_3_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_0])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_safari_3_0_when_minimum
    request  = create_request(:minimum_safari => 3.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_safari_3_0_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_0_1])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_safari_3_0_1_when_minimum
    request  = create_request(:minimum_safari => 3.0)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_0_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_safari_3_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_1])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_safari_3_1_when_minimum
    request  = create_request(:minimum_safari => 3.1)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_safari_3_1_2
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_1_2])
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_safari_3_1_2_when_minimum
    request  = create_request(:minimum_safari => 3.1)
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_3_1_2])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_4_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_4_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_4_0_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_4_0_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_4_0_dp1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_4_0_dp1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_4_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_4_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_0
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_0])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_0_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_0_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_1
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_1])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_1_2
    request  = create_request
    response = request.get("/", "HTTP_USER_AGENT" => USER_AGENTS[:safari_5_1_2])
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end
end
