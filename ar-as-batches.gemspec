# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ar-as-batches/version"

Gem::Specification.new do |s|
  s.name        = "ar-as-batches"
  s.version     = ActiveRecord::AsBatches::VERSION
  s.authors     = ["Daniel Barlow"]
  s.email       = ["dan@telent.net"]
  s.homepage    = ""
  s.summary     = "Retrieve AR objects from a query in RAM-friendly batches"
  s.description = %q{Retrieve AR objects from a relation in RAM-friendly batches, honouring limits offsets and orders }

  s.rubyforge_project = "ar-as-batches"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "sqlite3"
  s.add_runtime_dependency "activerecord"
end
