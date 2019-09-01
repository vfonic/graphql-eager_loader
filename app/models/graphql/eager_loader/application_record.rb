module Graphql
  module EagerLoader
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
