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

  def test_version
    assert_equal "1.3.0", Rack::Bouncer::VERSION
  end

  def test_default_safe_paths
    expected = ["/asset", "/images", "/stylesheets", "/javascripts", "/feedback"]
    assert_equal expected, Rack::Bouncer::DEFAULT_OPTIONS[:safe_paths]
  end

  def test_default_redirect
    assert_equal "http://browsehappy.com/", Rack::Bouncer::DEFAULT_OPTIONS[:redirect]
  end

  def test_default_minimum_ie
    assert_equal 8.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_ie]
  end

  def test_default_minimum_firefox
    assert_equal 4.0, Rack::Bouncer::DEFAULT_OPTIONS[:minimum_firefox]
  end

  def test_allows_if_no_user_agent_specified
    request  = create_request
    response = request.get("/")
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Internet Explorer
  #################################################################################################

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
  #################################################################################################

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
  #################################################################################################

  def test_expels_firefox_3_6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0(Windows; U; Windows NT 5.2; rv:1.9.2) Gecko/20100101 Firefox/3.6" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_firefox_3_6_when_minimum
    request  = create_request(:minimum_firefox => 3.6)
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0(Windows; U; Windows NT 5.2; rv:1.9.2) Gecko/20100101 Firefox/3.6" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_firefox_3_6_2
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.2.2) Gecko/20100316 Firefox/3.6.2" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_6_b5
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2b5) Gecko/20091204 Firefox/3.6b5" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_6_22
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; U; PPC Mac OS X 10.4; en-US; rv:1.9.2.22) Gecko/20110902 Firefox/3.6.22" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_expels_firefox_3_8
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.9.0.2) Gecko/20121223 Ubuntu/9.25 (jaunty) Firefox/3.8" })
    assert_equal 302, response.status
    assert_equal response.location, "http://browsehappy.com/"
  end

  def test_allows_firefox_4
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows NT 6.1; rv:2.0.1) Gecko/20100101 Firefox/4.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_4_0_1
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (X11; Linux i686; rv:2.0.1) Gecko/20110518 Firefox/4.0.1" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_5
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows NT 5.1; U; rv:5.0) Gecko/20100101 Firefox/5.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_6
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Windows NT 6.1; rv:6.0) Gecko/20110814 Firefox/6.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_9
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20100101 Firefox/9.0" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_9_0_a2
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0a2) Gecko/20111101 Firefox/9.0a2" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_firefox_10_0_a4
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/6.0 (Macintosh; I; Intel Mac OS X 11_7_9; de-LI; rv:1.9b4) Gecko/2012010317 Firefox/10.0a4" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Safari
  #################################################################################################

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
  #################################################################################################

  def test_allows_chrome_16
    request  = create_request
    response = request.get("/", {"HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/535.7 (KHTML, like Gecko) Chrome/16.0.912.77 Safari/535.7" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  # Safe Paths
  #################################################################################################

  def test_allows_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/browser", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_expels_non_redirect_path
    request  = create_request(:redirect => "/browser")
    response = request.get("/wrong", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 302, response.status
    assert_equal response.location, "/browser"
  end

  def test_allows_assets_path
    request  = create_request
    response = request.get("/asset", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_images_path
    request  = create_request
    response = request.get("/images", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_stylesheets_path
    request  = create_request
    response = request.get("/stylesheets", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_javascripts_path
    request  = create_request
    response = request.get("/javascripts", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

  def test_allows_feedback_path
    request  = create_request
    response = request.get("/feedback", {"HTTP_USER_AGENT" => "Mozilla/4.0 (MSIE 6.0; Windows NT 5.1)" })
    assert_equal 200, response.status
    assert_equal "Hi Internets!", response.body
  end

end
