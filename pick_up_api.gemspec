Gem::Specification.new do |s|
  s.name = 'pickup_api'
  s.version = '0.1'
  s.authors = ['Kinderly LTD']
  s.email = 'pustserg@yandex.ru'
  s.homepage = 'https://github.com/kinderly/pickup_api'
  s.summary = 'A wrapper for Pick Up API'
  s.description = 'This gem provides a Ruby wrapper over Pick Up API'
  s.license = 'MIT'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'savon'
  s.add_dependency 'nokogiri'
  s.add_dependency 'nori'
end
