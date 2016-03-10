# This script introduces a set of predefined/convenience parsers.

require 'stringio'
require 'colorize'

module Caracas

  module Parser

    SimpleDumper = Parser::Factory.build do
      def start_schema
        context[:stream] = StringIO.new
      end
      def end_schema
        context[:stream].string
      end
      def start_element
        ev = context.event
        case ev.element
        when :table
          context[:stream].puts "#{ev.args[0].magenta} {"
        when :column
          context[:stream].puts "  #{ev.args[0].brown} : #{ev.args[1]};"
        when :tags
          context[:stream].puts "  tags : #{ev.args[0]};"
        else
          STDERR.puts "unknown element: #{ev.element}".red
        end
      end
      def end_element
        context[:stream].puts "}" if context.event.element == :table
      end
    end

    # {:tables => [ {:name => 'user', :columns => [{:name => 'count', :type => :integer}]}]}
    HashModeler = Parser::Factory.build do
      def start_schema
        context[:model] = {name: context.schema_name}
      end
      def end_schema
        context[:model]
      end
      def start_element
        ev = context.event
        case ev.element
        when :table
          tables = (context[:model][:tables] ||= [])
          tables << {name: ev.args[0]}
          context[:current_table] = tables.last
        when :desc
          context[:current_table][:desc] = ev.args[0]
        when :column
          columns = (context[:current_table][:columns] ||= [])
          col = {name: ev.args[0], type: ev.args[1]}
          col[:opts] = ev.args[2] unless ev.args[2].nil? or ev.args[2].empty?
          columns << col
        when :fk
          fks = (context[:current_table][:fks] ||= [])
          fk = {column: ev.args[0], table: ev.args[1]}
          fk[:opts] = ev.args[2] unless ev.args[2].nil? or ev.args[2].empty?
          fks << fk
        when :tags
          context[:current_table][:tags] = ev.args[0]
        when :plantuml
          plantumls = (context[:current_table][:plantumls] ||= [])
          plantumls << ev.args[0]
        when :graphviz
          graphvizs = (context[:current_table][:graphvizs] ||= [])
          graphvizs << ev.args[0]
        else
          STDERR.puts "unknown element: #{ev.element}".red
        end
      end
    end

  end # Parser

end # Caracas