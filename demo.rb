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
puts sch.parse Caracas::Parser::SimpleDumper.new

# transfer to Hash/Array based object model
puts '==================='.green
require 'pp'
model = sch.parse Caracas::Parser::HashModeler.new
pp model

# tag based filtering
puts '==================='.green
filtered = Caracas::Mapper::TagFilter.new(model, :foo).map
pp filtered

# vizualization
puts '==================='.green
gv = Caracas::Graphviz.new(model)
puts gv.map
