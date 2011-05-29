# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_eav/version"

Gem::Specification.new do |s|
  s.name        = "simple_eav"
  s.version     = SimpleEav::VERSION
  s.authors     = ["Tim Linquist"]
  s.email       = ["tim.linquist@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{A simple alternative to acts_as_eav_model.}
  s.description = %q{A simple alternative to acts_as_eav_model that works with ActiveRecord without any monkey patching needed.  Acts_as_eav_model's gives a model the ability to have any number of custom attributes.  This project has the same goal.  The difference being maintaining utmost compatability with ActiveRecord::Base.}

  s.rubyforge_project = "simple_eav"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
