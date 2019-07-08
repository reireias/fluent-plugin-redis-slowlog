# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-redis-slowlog"
  spec.version       = "0.0.2"
  spec.authors       = ["shingo suzuki"]
  spec.email         = ["s_suzuking@icloud.com"]
  spec.description   = "Redis slowlog input plugin for Fluent event collector"
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/mominosin/fluent-plugin-redis-slowlog"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake" 
  spec.add_development_dependency "test-unit"
  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency "redis"
end
