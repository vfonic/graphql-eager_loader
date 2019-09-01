# Graphql::EagerLoader

Eager-load your Active Record associations automagically.

## Usage

Call this method like this:

```ruby
Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead)
```

Here's a full example with 'graphql' field:

```ruby
field :projects, Types::ProjectType.connection_type, null: true, extras: [:lookahead]
def projects(lookahead:)
  Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead).all # or: .where(published: true)
end
```

This method allows you to add additional functionality while eager loading app's models.
For example you can do stuff like (notice the location of `.all` below):

```ruby
field :projects, Types::ProjectType.connection_type, null: true, extras: [:lookahead]
def projects(lookahead:)
  Graphql::EagerLoader::LookaheadLoader.call(Project, lookahead) do |eager_loaded_model, associations|
    associations.values.each do |association|
      if association.instance_of?(ActiveRecord::Reflection::HasManyReflection)
        eager_loaded_model = eager_loaded_model.merge(association.klass.where(published: true))
      end
    end
    eager_loaded_model
  end.all
end
```

## Installation

```ruby
gem 'graphql-eager_loader'
```

And then execute:

```bash
$ bundle install
```

## Contributing

Contributions welcome!

## Special Thanks

Thank you to [@colinjfw](https://github.com/colinjfw) for the great [GraphQL-Api](https://github.com/colinjfw/graphql-api) gem that inspired this.

Thank you to [@rmosolgo](https://github.com/rmosolgo) for the incredible [GraphQL](https://github.com/rmosolgo/graphql-ruby) gem.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
