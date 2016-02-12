module Caracas

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
