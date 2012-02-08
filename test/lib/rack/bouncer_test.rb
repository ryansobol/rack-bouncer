# encoding: UTF-8
require "rubygems"
require "minitest/autorun"
require "rack/mock"

require "rack/bouncer"

class TestApp
  def call(env)
    [200, {}, "Hi Internets!"]
  end
end

def create_request(options = {})
  Rack::MockRequest.new(Rack::Bouncer.new(TestApp.new, options))
end

class Rack::Bouncer::Test < MiniTest::Unit::TestCase

  def test_allows_if_no_user_agent_specified
    request  = create_request
    response = request.get("/")
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Internet Explorer
  #############################################################################

  def test_allows_if_not_ie
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0"})
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_if_no_version_available
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE l4me; Windows XP)"})
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_ie_6_and_redirects_to_default
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_ie_6_and_redirects_to_internal_url
    request  = create_request(:redirect => "/foo")
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "/foo"
  end

  def test_expels_ie_6_and_redirects_to_external_url
    request  = create_request(:redirect => "http://getfirefox.com")
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://getfirefox.com"
  end

  def test_allows_ie_6_when_minimum
    request  = create_request(:minimum_ie => 6.0)
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_ie_7
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_ie_7_when_minimum
    request  = create_request(:minimum_ie => 7.0)
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "User-Agent:Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_8_when_minimum
    request  = create_request(:minimum_ie => 8.0)
    response = request.get("/", {"HTTP_USER_AGENT" => "User-Agent:Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_ie_9
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0;" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # AOL
  #############################################################################

  def test_expels_aol_6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 5.5; AOL 6.0; Windows 98)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_7
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; AOL 7.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_8
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; AOL 8.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_1
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.1; AOLBuild 4334.5000; Windows NT 5.1; Trident/4.0)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_5
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.5; AOLBuild 4337.43; Windows NT 5.1; Trident/4.0)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_aol_9_6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/4.0 (compatible; MSIE 8.0; AOL 9.6; AOLBuild 4340.5004; Windows NT 5.1; Trident/4.0)" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  # Firefox
  #############################################################################

  def test_allows_firefox_4
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Safari
  #############################################################################

  def test_allows_safari_5_0
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0 Safari/533.16" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_safari_5_1
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_8; en-us) AppleWebKit/534.52.7 (KHTML, like Gecko) Version/5.1 Safari/534.52.7" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Chrome
  #############################################################################

  def test_allows_chrome_16
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

end
