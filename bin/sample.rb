$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')
require 'dogen'

env_params = { key: 'world' }
env = Dogen::Enviroment.new(env_params)
builder = Dogen::Builder.new(env)
builder.add_template Dogen::Template.new(
  :raw_body => <<EOS,
hello <%= key %> !!!
EOS
  :name     => 'sample',
)
dogen = Dogen.new(builder)
templates = dogen.render

templates.each do |t|
  puts t.rendered_body
end
