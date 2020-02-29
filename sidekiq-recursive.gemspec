lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq/recursive/version'

Gem::Specification.new do |spec|
  spec.name          = 'sidekiq-recursive'
  spec.version       = Sidekiq::Recursive::VERSION
  spec.authors       = 'Justas Kazakauskas'
  spec.email         = 'leakymirror@gmail.com'

  spec.summary       = 'Use simple recursion to limit sidekiq workers per job'
  spec.description   = 'Use simple recursion to limit sidekiq workers per job.'
  spec.homepage      = 'https://github.com/justaskz/sidekiq-recursive'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'sidekiq', '>= 3.0', '~> 5.1'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'fakeredis', '~> 0.7.0'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
end
