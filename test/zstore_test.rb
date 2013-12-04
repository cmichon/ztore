require 'test_helper'

module MyTest
  def runner(type)
    db = @db
    assert_instance_of Ztore::DB, db

    db.tree :People
    assert_equal Ztore::Tree, People.superclass
    assert_equal [:People], db.trees
    assert_equal [], People.entries

    People[0] = 'CM'
    People[1] = {
      :name => 'CM',
      :features => {
        :developer => true
      }
    }

    assert People.key?(0)
    assert People.key?(1)
    assert_equal [1], People.regexp('^1$')
    assert_equal 2, People.size
    assert_equal 2, People.count
    assert_equal [0,1], People.keys

    assert_instance_of String, People[0]
    assert_equal 'CM', People[0]

    assert_instance_of Hash, People[1]
    assert_equal 'CM', People[1][:name]
    assert_instance_of Hash, People[1][:features]
    assert People[1][:features][:developer]

    People.clear
    assert_equal 0, People.count

    Object.send(:remove_const, :People)
  end
end

class ZtoreDBTest < Test::Unit::TestCase
  include MyTest
  def setup
    @file = Tempfile.new('testdb')
  end
  def teardown
  end 
  def test_ztore_db
    @db = Ztore::DB.new(@file.path)
    runner(:FileDB)
    File.delete "#{@file.path}.pstore"
  end
end
