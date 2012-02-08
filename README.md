# rack-bouncer

A Rack middleware that expels undesirable browsers out of your website.

| Browser           | Versions |
|-------------------|----------|
| Internet Explorer | >= 7     |
| AOL               | All      |

## usage

    gem install rack-bouncer
    require "rack/bouncer"

The default redirects users to [Browse Happy](http://browsehappy.com/), like so:

    use Rack::Bouncer

You can redirect users to a page in your website, like so:

    use Rack::Bouncer, redirect: "/bouncer.html"

You can redirect users to a URL as well, like so:

    use Rack::Bouncer, redirect: "http://slashdot.org"

You can even specify a minimum version of IE like so:

    use Rack::Bouncer, redirect: "http://slashdot.org", minimum: 6.0

## acknowledgments

Thanks to [juliocesar](http://github.com/juliocesar), [sant0sk1](http://github.com/sant0sk1), [wjessop](http://github.com/wjessop), and [robomc](https://github.com/robomc) for their contributions to Rack::NoIE6.

## license

Copyright (c) 2012 Ryan Sobol

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
