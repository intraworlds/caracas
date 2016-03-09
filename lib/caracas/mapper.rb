module Caracas

  module Mapper

    # An abstract class for a Mapper implementation.
    class Base

      # Constructor.
      #
      # @param model [Hash] a model produced by {Parser::HashModeler}
      # @param opts [Hash] options
      #
      # @see Caracas::Parser::HashModeler
      def initialize(model, opts={})
        raise 'missing model', ArgumentError if model.nil?
        raise 'missing :table entry in model', ArgumentError unless model.has_key? :tables
        raise 'missing :name entry in model', ArgumentError unless model.has_key? :name
        @opts = opts
        @model = model
      end

      # Maps the model and produces a corresponding output.
      #
      # @return [Object] some re-mapped representation of the model
      def map
        raise 'subclass must implement to return a value', NotImplementedError
      end

    end

  end

  def self.map_model(model, &block)
    model.inject({}) do |result, (key,value)|
      block.call(result, key, value)
      result
    end
  end

  # https://www.ruby-forum.com/topic/218112

  # http://devblog.avdi.org/2009/11/20/hash-transforms-in-ruby/
  # def self.map_modelX(model, opts, &block)
  #   model.inject({}) do |result, (key,value)|
  #     value = if (opts[:deep] && Hash === value)
  #               self.map_model(value, opts, &block)
  #             else
  #               value
  #             end
  #     block.call(result, key, value)
  #     result
  #   end
  # end

end
