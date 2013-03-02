# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','rmw_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'rmw'
  s.version = Rmw::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/rmw
lib/rmw_version.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','rmw.rdoc']
  s.rdoc_options << '--title' << 'rmw' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'rmw'
  s.add_development_dependency('capybara-webkit')
  s.add_development_dependency('capybara')
  s.add_development_dependency('launchy')
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_runtime_dependency('gli')
end
