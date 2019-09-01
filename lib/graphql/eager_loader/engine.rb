# frozen_string_literal: true

require 'rails/engine'
require 'action_dispatch/railtie'

module Graphql
  module EagerLoader
    class Engine < ::Rails::Engine
      engine_name 'graphql-eager_loader'
      isolate_namespace Graphql::EagerLoader
    end
  end
end
