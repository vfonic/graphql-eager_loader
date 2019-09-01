# frozen_string_literal: true

module Graphql::EagerLoader
  class LookaheadLoader
    # Call this method like this:
    # Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead)
    #
    # Here's a full example with 'graphql' field:
    #
    # field :projects, Types::ProjectType.connection_type, null: true, extras: [:lookahead]
    # def projects(lookahead:)
    #   Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead).all # or: .where(published: true)
    # end
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
      selection_names = lookahead.selections.map(&:name)
      if selection_names == %i[edges nodes] || selection_names == [:nodes]
        lookahead.selections.find { |lookahead| lookahead.name == :nodes }.selections
      else
        lookahead.selections
      end
    end

    # This method allows you to add additional functionality while eager loading app's models.
    # For example you can do stuff like (notice the location of `.all` below):
    #
    # field :projects, Types::ProjectType.connection_type, null: true, extras: [:lookahead]
    # def projects(lookahead:)
    #   Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead) do |eager_loaded_model, associations|
    #     associations.values.each do |association|
    #       if association.instance_of?(ActiveRecord::Reflection::HasManyReflection)
    #         eager_loaded_model = eager_loaded_model.merge(association.klass.where(published: true))
    #       end
    #     end
    #     eager_loaded_model
    #   end.all
    # end
    def self.eager_load_associations(model_class, associations, &block)
      return model_class if associations.blank?

      eager_loaded_model = model_class.eager_load(*associations.keys)

      eager_loaded_model = yield eager_loaded_model, associations if block_given?

      eager_loaded_model
    end
  end
end
