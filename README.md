      ___ __ _ _ __ __ _  ___ __ _ ___
     / __/ _` | '__/ _` |/ __/ _` / __|
    | (_| (_| | | | (_| | (_| (_| \__ \
     \___\__,_|_|  \__,_|\___\__,_|___/



Management od a database schema represents not only a definition, but a lot of additional supporting task as well
 * documentation
 * vizualization
 * evolution (migrations)
 * 'the same version' policy in a multi-tenancy system
 * creation of data set for unit/integration testing

At the same time I would like to have only one, DSL based, human readable and pleasantly fotmatted schema definition. Let me introduce the answer: Caracas

## Schema definition

```ruby
Caracas.schema 'demo' do

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
```

