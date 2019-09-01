# frozen_string_literal: true

Rails.application.routes.draw do
  mount Graphql::EagerLoader::Engine => '/graphql-eager_loader'
end
