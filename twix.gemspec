require File.expand_path("../lib/twix/version", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{twix}
  s.version = Twix::VERSION
  s.date = Time.now.strftime("%Y-%m-%d")
  s.authors = ["Charles Max Wood"]
  s.email = %q{chuck@teachmetocode.com}
  s.summary = %q{Executes a Tweet as Ruby Code}
  s.homepage = %q{http://teachmetocode.com/}
  s.description = %q{Pulls down a specified tweet and executes its contents as ruby code}
  s.add_dependency('twitter', '~> 4.1.0')
  s.add_dependency('oauth', '~> 0.4.7')
  s.add_dependency('rubycop', '~> 1.0.1')
  s.add_development_dependency('rspec')
  s.add_development_dependency('bundler')
  s.files = [ "README.md", 
              "MIT-LICENSE", 
              "lib/twix.rb"]
end

