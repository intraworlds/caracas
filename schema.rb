require 'caracas'

sch = Caracas.schema 'demo' do
    table 'user' do
        column 'id', :integer, null: false
        column 'name', :text
        tags [:beta]
        # index 'idx_name'
    end

    table 'ahoj' do
        tags ['alfa', :beta]
    end
end

# simple text vizualization
puts sch.parse Caracas::SimpleDumpParser.new

# transfer to Hash/Array based object model
puts '==================='.green
require 'pp'
model = sch.parse Caracas::HashModelParser.new
pp model

# tag based filtering
puts '==================='.green
filtered = Caracas.map_model(model, &Caracas::TagFilterMapper.new('alfa'))
pp filtered

# vizualization
puts '==================='.green
gv = Caracas::GraphViz.new
model[:tables].each &gv.block
puts gv.dot
