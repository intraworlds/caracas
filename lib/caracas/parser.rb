# This script represents a way for parsing schema by exposing a simple iterator based API.
# Iterator Parser is faster and uses less memory than a Model based parser.

module Caracas

  # Extension of the class for iterator based schema parsing.
  class Schema

    def parse(parser)
      @parser = parser
      @parser.context.schema_name = name
      @parser.start_schema
      self.instance_eval(&lambda)
      @parser.end_schema
    end


    def table(name, opts={}, &block)
      fire_element_event(:start, :table, [name])
      self.instance_eval(&block) if block_given?
      fire_element_event(:end, :table, [name])
    end
    def desc(value)
      fire_element_event(:start, :desc, [value])
      fire_element_event(:end, :desc, [value])
    end
    def column(name, type, opts={}, &block)
      fire_element_event(:start, :column, [name, type, opts])
      self.instance_eval(&block) if block_given?
      fire_element_event(:end, :column, [name, type, opts])
    end
    def fk(colname, desttable, opts={}, &block)
      fire_element_event(:start, :fk, [colname, desttable, opts])
      self.instance_eval(&block) if block_given?
      fire_element_event(:end, :fk, [colname, desttable, opts])
    end
    def tags(names, &block)
      fire_element_event(:start, :tags, [names])
      self.instance_eval(&block) if block_given?
      fire_element_event(:end, :tags, [names])
    end
    def graphviz(text)
      fire_element_event(:start, :graphviz, [text])
      fire_element_event(:end, :graphviz, [text])
    end

    private

    def fire_element_event(action, el, args)
      @parser.context.event = Caracas::Parser::Event.new(el, action, args)
      if :start == action
        @parser.start_element
      else
        @parser.end_element
      end
    end
  end


  module Parser
    class Factory
      class << self
        # Declare shared functionality in modules so subclasses may call super if they desire.
        module ParserInstanceMethods
          def start_schema
            # blah
          end
          def end_schema
            # blah
          end
          def start_element
            # blah
          end
          def end_element
            # blah
          end
          # def start_schema
          #   raise NotImplementedError, 'subclass must implement'
          # end
          def context
            @ctx ||= Context.new
          end
        end

        def build(&block)
          raise ArgumentError, 'block required!' unless block_given?

          Class.new do
            include ParserInstanceMethods

            # block is evaluated so new methods can be defined or existing ones redefined
            class_eval(&block)
          end
        end
      end
    end

    class Context < Hash
      attr_accessor :event
      attr_accessor :schema_name
    end

    Event = Struct.new(:element, :action, :args)

  end # Parser
end # Caracas