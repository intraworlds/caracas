module Caracas

  module Mapper

    class PlantUML < Base

    # Maps the model and produces the formatted text that can be vizualized by PlantUML.
    #
    # @return [String] textual representation of model in PlantUML format
    def map
      rslt = StringIO.new
      rslt.puts '@startuml'

      @model[:tables].each do |table|
        # nodes
        desc = table[:desc].split.each_slice(3).map{ |a| a.join ' '}.join "\n  "
        rslt.puts "Class #{table[:name]} << (T,#FF7700) >> {\n  #{desc}\n  --\n}"
        # edges
        table.fetch(:fks, []).each do |fk|
          rslt.puts "#{table[:name]} --> #{fk[:table]}"
        end
      end

      rslt.puts '@enduml'
      rslt.string
    end

    end

  end

end