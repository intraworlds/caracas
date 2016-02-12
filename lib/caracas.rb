require 'caracas/parser'
require 'caracas/simple_parsers'
require 'caracas/mapper'
require 'caracas/simple_mappers'
require 'caracas/graphviz'

module Caracas

  def self.schema(name, &block)
    raise ArgumentError, 'name is blank' if name.nil? or name.strip.empty?
    raise ArgumentError, 'block required!' unless block_given?

    schema = Schema.new
    schema.name = name
    schema.lambda = block
    schema
  end

  class Schema
    attr_accessor :name
    attr_accessor :lambda
  end

end
