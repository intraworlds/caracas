module Caracas

  class GraphViz
    attr_reader :block

    def initialize(opts={})
      shape = opts.fetch :shape, 'record'
      @nodes = StringIO.new
      @edges = StringIO.new

      @block = Proc.new do |table|
        # nodes
        @nodes.puts "  \"#{table[:name]}\" [label=\"#{table[:name]}\", shape=\"#{shape}\"]"
        # edges
        table.fetch(:fks, []).each do |fk|
          @edges.puts "  \"#{table[:name]}\"->\"#{fk[:table]}\""
        end
      end
    end

    def dot
      rslt = StringIO.new
      rslt.puts 'digraph demo {'
      rslt.puts '  graph [rankdir="LR"]'
      rslt.puts ''
      rslt.puts @nodes.string
      rslt.puts ''
      rslt.puts @edges.string
      rslt.puts '}'
      rslt.string
    end
  end

end