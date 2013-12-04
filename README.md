# Ztore

This gem allows easy creation of in-memory hashes and persists them into a pstore file.

## Installation

Add this line to your application's Gemfile:

    gem 'ztore'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ztore

## Usage

Use case 1: initial data creation

~~~ ruby

require 'ztore'
db = Ztore::DB.new(:db) # => will create file 'db.pstore'
db.tree :People # this will derive a class 'People' from Ztore::Tree, usable as a Hash

People[0] = 'CM'
p People[0]

People[1] = { :name => 'CM', :features => { :developer => true } }
p People[1]

db.save # this is needed at the end of your script to store

~~~

Use case 2: use a previously created Ztore::DB

~~~ ruby

require 'ztore'
db = Ztore::DB.new(:db) # => will load file 'db.pstore' and recreate all Ztore::Tree

p People[0] # 'CM'
p People[1] # { :name => 'CM', :features => { :developer => true } }

~~~


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
