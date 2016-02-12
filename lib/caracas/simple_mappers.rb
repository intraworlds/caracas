module Caracas

  class TagFilterMapper < Proc
    def self.new(tag)
      super() do |result, key, value|
        if key == :tables
          result[key] = value.select do |table| # filter tables containing given tag
            table.has_key?(:tags) and !table[:tags].nil? and !table[:tags].empty? and table[:tags].include?(tag)
          end
        else
          result[key] = value
        end
      end
    end
  end

end