Gem::Specification.new do |spec|
  spec.name                  = 'sidekiq-recursive'
  spec.version               = '0.2.3'
  spec.authors               = 'Justas Kazakauskas'
  spec.email                 = 'leakymirror@gmail.com'
  spec.summary               = 'Use simple recursion to limit sidekiq workers per job'
  spec.description           = 'Use simple recursion to limit sidekiq workers per job.'
  spec.homepage              = 'https://github.com/justaskz/sidekiq-recursive'
  spec.license               = 'MIT'
  spec.required_ruby_version = '>= 2.7'
  spec.files                 = Dir['lib/**/*.rb']
  spec.require_paths         = ['lib']

  spec.add_runtime_dependency 'sidekiq', '>= 3.0', '< 8.0'
end
