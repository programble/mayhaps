Gem::Specification.new do |s|
  s.name        = 'mayhaps'
  s.version     = '0.3.0'
  s.license     = 'ISC'
  s.authors     = ['Curtis McEnroe']
  s.email       = ['programble@gmail.com']
  s.homepage    = 'https://github.com/programble/mayhaps'
  s.summary     = 'Mayhaps (maybe) call Ruby methods'
  s.description = s.summary

  s.files           = `git ls-files`.split("\n")
  s.require_paths   = ['lib']
end
