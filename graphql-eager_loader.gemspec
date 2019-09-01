# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'graphql/eager_loader/version'

Gem::Specification.new do |s|
  s.name        = 'graphql-eager_loader'
  s.version     = Graphql::EagerLoader::VERSION
  s.authors     = ['Viktor Fonic']
  s.email       = ['viktor.fonic@gmail.com']
  s.homepage    = 'https://github.com/vfonic/graphql-eager_loader'
  s.summary     = 'Eager load Active Record relationships in your GraphQL queries'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.0.0'

  s.add_development_dependency 'sqlite3'
end
