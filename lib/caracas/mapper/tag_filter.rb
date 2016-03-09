module Caracas

  module Mapper

    # Class to filter tables in hash model according to given tags.
    # This implementation iterates over all `table` entries in model produced by {Parser::HashModel}.
    #
    # @example generate a dot format file
    #   tf = Caracas::Mapper::TagFilter.new(model, 'foo')
    #   filtered = tf.map
    class TagFilter

      # Constructor.
      #
      # @param model [Hash] a model produced by {Parser::HashModeler}
      # @param tag [String|Symbol] a tag we are looking for
      #
      # @see Parser::HashModeler
      def initialize(model, tag)
        raise 'missing model', ArgumentError if model.nil?
        raise 'missing :table entry in model', ArgumentError unless model.has_key? :tables
        raise 'missing tag', ArgumentError if tag.nil?
        @model = model
        @tag = tag
      end

      # Maps the model and produces a cloned model with tagged tables only.
      #
      # @return [Hash] hash based model
      def map
        cloned = Marshal.load(Marshal.dump(@model))
        cloned[:tables].select! do |table|
          table.has_key?(:tags) and !table[:tags].nil? and !table[:tags].empty? and table[:tags].include?(@tag)
        end
        cloned
      end

    end

  end

end