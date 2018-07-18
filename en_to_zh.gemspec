$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "en_to_zh/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "en_to_zh"
  s.version     = EnToZh::VERSION
  s.authors     = ["jayzen"]
  s.email       = ["jayzen@foxmail.com"]
  s.homepage    = "https://www.zhengjiajun.com"
  s.summary     = "translation from english to chinese"
  s.description = "translation from english to chinese"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.2.0"

  s.add_development_dependency "sqlite3"
end
