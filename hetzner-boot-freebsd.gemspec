# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hetzner/boot/freebsd/version"

Gem::Specification.new do |spec|
  spec.name        = "hetzner-boot-freebsd"
  spec.version     = Hetzner::Boot::FreeBSD::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ["Christoph Pilka"]
  spec.email       = ["c.pilka@asconix.com"]
  spec.summary     = %q{Reboot a Hetzner server into FreeBSD rescue environment}
  spec.description = %q{Allows to reboot a physical server hosted at Hetzner into a minimal FreeBSD recscue environment taht is based on mfsBSD.}
  spec.homepage    = "http://www.asconix.com"
  spec.license     = "BSD-3"

  spec.add_dependency 'hetzner-api', '~> 1.1.0'
  spec.add_dependency 'net-ssh', '~> 2.9.2'
  spec.add_dependency 'erubis', '~> 2.7.0'
  spec.add_dependency 'colorize', '~> 0.7.5'
  spec.add_dependency 'highline', '~> 1.7.1'
  spec.add_dependency 'dotenv', '~> 2.0.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "coveralls"

  spec.add_runtime_dependency "crimp"
end
