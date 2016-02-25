module Caracas

  # Class to generate a Graphviz vizualization of a schema.
  # This implementation iterates over all `table` entries in {HashModelParser} model
  #
  # @example generate a dot format file
  #   gv = Caracas::Graphviz.new(model)
  #   File.open('demo.dot', 'w') { |file| file.write(gv.dot) }
  #
  # @example additional processing of the generated file
  #   `dot -Tpng demo.dot > output.png`
  #   `feh output.png`
  class Graphviz

    # Constructor.
    #
    # @param model [Hash] a model produced by {HashModelParser}
    # @param opts [Hash] options
    #
    # @see HashModelParser
    def initialize(model, opts={})
      @opts = opts
      @model = model
      raise 'missing :table entry in model', ArgumentError unless model.has_key? :tables
      raise 'missing :name entry in model', ArgumentError unless model.has_key? :name
    end

    # Produces the 'dot' formatted text that can be vizualized by Graphviz.
    #
    # @return textual of model representation in Graphviz format
    def dot
      shape = @opts.fetch :shape, 'record'
      rslt = StringIO.new
      rslt.puts "digraph #{@model[:name]} {"
      rslt.puts '  graph [rankdir="LR"]'
      rslt.puts ''

      @model[:tables].each do |table|
        # nodes
        rslt.puts "  \"#{table[:name]}\" [label=\"#{table[:name]}\", shape=\"#{shape}\"]"
        # @nodes.puts "  \"#{table[:name]}\" [label=\"<f0> #{table[:name]}|<f1> #{table[:desc]}\", shape=\"#{shape}\"]"
        # edges
        table.fetch(:fks, []).each do |fk|
          rslt.puts "  \"#{table[:name]}\"->\"#{fk[:table]}\""
        end
        # graphviz
        table.fetch(:graphvizs, []).each do |text|
          rslt.puts "  #{text}"
        end
      end

      rslt.puts '}'
      rslt.string
    end
  end

end