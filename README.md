# rack-bouncer

rack-bouncer does _everyone_ a favor: it shows the way out of your website to poor souls out there using Internet Explorer 6 (or a user configurable minimum).

Originally developed by [juliocesar](http://github.com/juliocesar), [sant0sk1](http://github.com/sant0sk1) forked and gemified for easier distribution, [wjessop](http://github.com/wjessop) added the minimum version option, and [robomc](https://github.com/robomc) made it pass `Rack::Lint`.

# usage

    gem install rack-bouncer
    require "rack/bouncer"

and

    use Rack::Bouncer, redirect: "/noieplease.html"

the above will redirect to a page noieplease.html in your website. You can redirect to
a URL as well, like so

    use Rack::Bouncer, redirect: "http://slashdot.org"

or let the default kick in

    use Rack::Bouncer

You can even specify a minimum version of IE like so

    use Rack::Bouncer, redirect: "http://slashdot.org", minimum: 6.0

# disclaimer

The default URL points to Microsoft's IE upgrade page.

# acknowledgments

Thanks to Jerod Santo, Julio Cesar Ody, and Will Jessop for their contributions to Rack::NoIE6.

# license

MIT
