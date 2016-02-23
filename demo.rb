require 'caracas'

sch = Caracas.schema 'demo' do

  table 'user' do
    tags [:foo]
    column 'email', :text, {null: false, limit: 255}
    column 'name',  :text, {null: false, limit: 255}
    column 'age',   :integer
  end

  table 'address' do
    tags [:foo, :bar]
    column 'street', :text, {null: false, limit: 255}
    column 'city',  :text, {null: false, limit: 255}
    fk 'user_id', 'user'
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
model[:tables].each(&gv.block)
puts gv.dot
