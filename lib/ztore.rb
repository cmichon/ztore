%w[forwardable ztore/version pstore].map &method(:require)

module Ztore
  module ClassMethods
    extend Forwardable
    def_delegators :@tree, *%w[
      [] []= clear count each entries first key? keys last map select size value? values
    ].map(&:to_sym)
    def regexp(pattern)
      re = Regexp.new "#{pattern}", Regexp::EXTENDED | Regexp::IGNORECASE
      keys.select{ |k,v| "#{k}" =~ re }
    end
  end
  class DB
    def initialize(dbname=nil)
      @pstore = PStore.new("#{dbname}.pstore")
      @pstore.transaction do
        @trees = @pstore.roots
        @trees.map &method(:tree)
      end
    end
    def tree(treename)
      unless Object.const_defined?(treename)
        Object.const_set treename, Class.new(Tree)
        if @trees.include?(treename)
          Object.const_get(treename).instance_variable_set :@tree, @pstore[treename]
        else
          Object.const_get(treename).instance_variable_set :@tree, Hash.new
          @trees << treename
        end
      end
      Object.const_get treename
    end
    def trees
      @trees
    end
    def save
      @pstore.transaction do
        @trees.each do |treename|
          @pstore[treename] = Object.const_get(treename).instance_variable_get :@tree
        end
      end
    end
  end
  class Tree
    extend ClassMethods
  end
end
