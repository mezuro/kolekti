# Kolekti

[![Code Climate](https://codeclimate.com/github/mezuro/kolekti.png)](https://codeclimate.com/github/mezuro/kalibro_client)

Kolekti is a code metric results parser framework. You can use it whenever you want structured unique output for different metric collectors.

## Contributing

Please, have a look the wiki pages about development workflow and code standards:

* https://github.com/mezuro/mezuro/wiki/Development-workflow
* https://github.com/mezuro/mezuro/wiki/Standards

## Installation

Add this line to your application's Gemfile:

    gem 'kolekti'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kolekti

### Important note about Ruby versions older than 2.2.2

Kolekti depends on [activesupport](https://github.com/rails/activesupport) to work.
AS version 5 dropped support for Ruby versions older than 2.2.2. Unfortunately,
RubyGems does not take that into account while selecting a Gem version to be installed.
It will attempt to install version 5 and fail in many cases.

If your project is not using Rails (which will already lock the AS version to it's own),
you need to add the following snippet to your Gemfile if you want to keep support
for those old Ruby versions.

```ruby
# Active Support 5 drops Ruby < 2.2.2 support. We still want to support it, so
# manually add a maximum version bound for incompatible Ruby versions.
if Gem::Version.new(RUBY_VERSION) < Gem::Version.new('2.2.2')
    gem 'activesupport', '< 5'
end
```

If you are installing Kolekti manually as outlined earlier, you must install a version
of f AS compatible with your Ruby installation first, by running the following command:

    gem install activesupport -v '< 5'

## Usage

You have one key class you need to extend `Kolekti::Collector` implementing the following methods:

* `collect_metrics(code_directory, wanted_metric_configurations)`
* `clean(code_directory, wanted_metric_configurations)`
* `default_value_from(metric_configuration)`

Actual examples are:

* [KolektiAnalizo](https://github.com/mezuro/kolekti_analizo)

## Versioning

Kolekti follows the [semantic versioning](http://semver.org/) policy.
