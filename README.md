# rack-bouncer

A Rack middleware that expels undesirable browsers out of your website. This project lovingly extends the `rack-noie6` gem.

| _Browser_         | _Undesirable Versions_ |
|-------------------|------------------------|
| AOL               | All                    |
| Chrome            | < 7.0                  |
| Firefox           | < 4.0                  |
| Internet Explorer | < 8.0                  |
| Safari            | < 4.0                  |

## usage

    gem install rack-bouncer
    require "rack-bouncer"

The default redirects users to [Browse Happy](http://browsehappy.com/):

    use Rack::Bouncer

You can redirect users to a page in your website:

    use Rack::Bouncer, :redirect => "/requirements.html"

You can redirect users to a URL as well:

    use Rack::Bouncer, :redirect => "https://www.google.com/chrome"

You can specify a minimum version of Chrome like so:

    use Rack::Bouncer, :minimum_firefox => 6.0

You can specify a minimum version of Firefox like so:

    use Rack::Bouncer, :minimum_firefox => 3.6

You can specify a minimum version of IE like so:

    use Rack::Bouncer, :minimum_ie => 6.0

You can specify a minimum version of Safari like so:

    use Rack::Bouncer, :minimum_safari => 3.0

You can specify a set of safe paths:

    use Rack::Bouncer, :safe_paths => ["/asset", "/images", "/stylesheets", "/javascripts", "/feedback"]

*NOTE:* By default, the above paths are safe already.

## warning

I use this gem in a production Rails app and it works great.  But in development, my app throws the following error whenever the `Rack::Bouncer` middleware is triggered:

    !! Unexpected error while processing request: thread 0x1001d5258 tried to join itself

I'm using the following versions of Ruby and Rails:

    $ ruby -v
    ruby 1.8.7 (2011-02-18 patchlevel 334) [i686-darwin10.7.0], MBARI 0x6770, Ruby Enterprise Edition 2011.03
    
    $ rails -v
    Rails 2.3.14

If anyone has a suggestion, I'd appreciate your help.

## contributing

Pull requests are very welcome. You'd be doing me a favor if you could test cover your enhancement and ensure the test suite passes *before* initiating a pull request.

## acknowledgments

Thanks to [juliocesar](http://github.com/juliocesar), [sant0sk1](http://github.com/sant0sk1), [wjessop](http://github.com/wjessop), and [robomc](https://github.com/robomc) for their contributions to `rack-noie6`.

## license

Copyright (c) 2012 Ryan Sobol

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
