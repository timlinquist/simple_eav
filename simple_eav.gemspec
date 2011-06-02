# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "version"

Gem::Specification.new do |s|
  s.name        = "simple_eav"
  s.version     = SimpleEav::VERSION
  s.authors     = ["Tim Linquist"]
  s.email       = ["tim.linquist@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple alternative to acts_as_eav_model.}
  s.description = %q{A simple alternative to acts_as_eav_model that works with ActiveRecord without any monkey patching needed.  Acts_as_eav_model's gives a model the ability to have any number of custom attributes.  This project has the same goal.  The difference being maintaining utmost compatability with ActiveRecord::Base.}

  # s.rubyforge_project = "simple_eav"

  lib_files = ['./lib/simple_eav.rb']
  s.files         = lib_files

  test_files = ['./spec/lib/simple_eav_spec.rb']
  s.test_files    = test_files
  # s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '~> 3.0.7'
  s.add_development_dependency 'sqlite3', '~> 1.3.3'
  s.add_development_dependency 'rspec', '~> 2.6.0'
end
