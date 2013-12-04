lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ztore/version'

Gem::Specification.new do |spec|
  spec.name          = 'ztore'
  spec.version       = Ztore::VERSION
  spec.authors       = ['Christian MICHON']
  spec.email         = ['christian.michon@gmail.com']
  spec.description   = %q{This gem allows easy creation of in-memory hashes and persists them into a pstore file.}
  spec.summary       = %q{Easy persistence of hashes into pstore}
  spec.homepage      = 'http://github.com/cmichon/ztore'
  spec.license       = 'MIT'

  spec.files         = Dir['{**/*}']
  spec.require_paths = ['lib']
end
