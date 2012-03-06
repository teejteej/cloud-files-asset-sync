# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cloud-files-asset-sync/version"

Gem::Specification.new do |s|
  s.name        = "cloud-files-asset-sync"
  s.version     = CloudfileAsset::VERSION
  s.authors     = ["teejteej"]
  s.email       = ["teeceeiks@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Forked from https://github.com/phillc/cloud-files-asset-sync}
  s.description = %q{Forked from https://github.com/phillc/cloud-files-asset-sync}

  s.rubyforge_project = "cloud-files-asset-sync"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "cloudfiles"
end
