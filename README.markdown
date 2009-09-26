# rack-noie6

rack-noie6 does _everyone_ a favor: it shows the way out of your website to poor souls out there using Internet Explorer 6 (or a user configurable minimum).

Originally developed by [juliocesar](http://github.com/juliocesar), [sant0sk1](http://github.com/sant0sk1) forked and gemified for easier distribution and [wjessop](http://github.com/wjessop) added the minimum version option.

# general usage

just 

    # from gemcutter (canonical)
    gem sources --add http://gemcutter.org
    gem install rack-noie6
    # from GitHub (development)
    gem sources --add http://gems.github.com
    gem install sant0sk1-rack-noie6
    
    require 'noie6'
    
and

    use Rack::NoIE6, :redirect => '/noieplease.html'
    
the above will redirect to a page noieplease.html in your website. You can redirect to
a URL as well, like so

    use Rack::NoIE6, :redirect => 'http://slashdot.org'
    
or let the default kick in

    use Rack::NoIE6
    
You can even specify a minimum version of IE like so

    use Rack::NoIE6, :redirect => 'http://slashdot.org', :minimum => 6.0
    
# Rails usage

inside environment.rb's Rails::Initializer.run

    config.gem 'sant0sk1-rack-noie6', :lib => 'noie6'
    config.middleware.use "Rack::NoIE6"
    
Piece o' cake!
    
# disclaimer

The default URL points to Microsoft's IE8 upgrade page.

# license

MIT
