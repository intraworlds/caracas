require 'caracas/parser'
#require 'caracas/mapper'
require 'caracas/simple_mappers'


# The main namespace of the tool.
module Caracas

  module Parser
    autoload :HashModeler, 'caracas/simple_parsers'
  end
  # module Mapper
    autoload :Graphviz, 'caracas/mapper/graphviz'
  # end

  # Basic entry point for a schema definition.
  # See {file:demo.rb demo definition} for more info.
  #
  # @param name [String] a logical name of the schema
  # @yield the DSL definition
  #
  # @return [Schema] an object representing the schema
  #
  # @see Schema
  def self.schema(name, &block)
    raise ArgumentError, 'name is blank' if name.nil? or name.strip.empty?
    raise ArgumentError, 'block required!' unless block_given?

    schema = Schema.new
    schema.name = name
    schema.lambda = block
    schema
  end

  # This class represents the schema definition.
  # It is only a data container to definition provided by {Caracas#schema}.
  class Schema
    attr_accessor :name
    attr_accessor :lambda
  end

end

# https://www.distelli.com