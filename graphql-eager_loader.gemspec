$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "graphql/eager_loader/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "graphql-eager_loader"
  s.version     = Graphql::EagerLoader::VERSION
  s.authors     = ["Viktor Fonic"]
  s.email       = ["viktor.fonic@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Graphql::EagerLoader."
  s.description = "TODO: Description of Graphql::EagerLoader."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.0.0"

  s.add_development_dependency "sqlite3"
end
