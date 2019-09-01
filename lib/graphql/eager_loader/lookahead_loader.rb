# frozen_string_literal: true

module Graphql::EagerLoader
  class LookaheadLoader
    # call this method with
    # Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead)
    def self.call(model_class, lookahead, &block)
      associations = self.associations(model_class, lookahead)

      eager_load_associations(model_class, associations, &block)
    end

    def self.associations(model_class, lookahead)
      self.selections(lookahead).map(&:name).map(&:to_s).map do |selection|
        model_class.reflections.find do |name, _association|
          name == selection
        end
      end.compact.to_h
    end

    def self.selections(lookahead)
      if lookahead.selections.map(&:name) == %i[edges nodes]
        lookahead.selections.second.selections
      else
        lookahead.selections
      end
    end

    def self.eager_load_associations(model_class, associations, &block)
      return model_class if associations.blank?

      eager_loaded_model = model_class.eager_load(*associations.keys)

      yield if block?

      associations.values.each do |association|
        if association.instance_of?(ActiveRecord::Reflection::HasManyReflection)
          # TODO: scope based on actual model policy
          eager_loaded_model = eager_loaded_model.merge(EventPolicy::Scope.new(nil, Event).resolve)
        end
      end

      eager_loaded_model
    end
  end
end
