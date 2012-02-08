# rack-bouncer

rack-bouncer does _everyone_ a favor: it shows the way out of your website to poor souls out there using Internet Explorer 6 (or a user configurable minimum).

## usage

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

## disclaimer

The default URL points to [Browse Happy](http://browsehappy.com/).

## acknowledgments

Thanks to [juliocesar](http://github.com/juliocesar), [sant0sk1](http://github.com/sant0sk1), [wjessop](http://github.com/wjessop), and [robomc](https://github.com/robomc) for their contributions to Rack::NoIE6.

## license

Copyright (c) 2012 Ryan Sobol

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
