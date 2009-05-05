require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name     = "sneaky_sender"
    s.summary  = %Q{Use multiple email accounts to send large numbers of email. Sneaky!}
    s.email    = "dave.myron@contentfree.com"
    s.homepage = "http://github.com/contentfree/sneaky_sender"
    s.authors  = ["Dave Myron"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'sneaky_sender'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.libs << 'lib' << 'spec'
  t.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |t|
  t.libs << 'lib' << 'spec'
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
end

task :default => :spec
