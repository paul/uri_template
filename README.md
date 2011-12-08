# URITemplate

Implements the URI Template draft spec, v7 http://tools.ietf.org/html/draft-gregorio-uritemplate-07

## Installation

Add this line to your application's Gemfile:

    gem 'uri_template'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install uri_template

## Usage

    tmpl = URITemplate.new("http://example.com/search{?q,lang}")
    tmpl.expand("q" => ["dogs", "cats"], "lang" => "en_US")
    # => "http://example.com/search?q=dogs&q=cats&lang=en_US"

See the spec for other examples.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
