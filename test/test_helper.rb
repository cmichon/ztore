$: << File.expand_path('../lib', __FILE__)
%w[rubygems tempfile test/unit ztore].map &method(:require)
