module Graphql
  module EagerLoader
    class Engine < ::Rails::Engine
      isolate_namespace Graphql::EagerLoader
    end
  end
end
