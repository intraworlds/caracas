require 'active_record'
require 'active_record/schema_dumper'
require 'mysql'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql',
  host: '192.168.50.50',
  database: 'trunk_demo_analyst',
  username: 'root',
  password: ''
)
# ActiveRecord::Base.schema_format = :sql

File.open('./dump.dsl', 'w:utf-8') do |file|
  ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
end
