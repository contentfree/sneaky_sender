# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sneaky_sender}
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dave Myron"]
  s.date = %q{2009-05-04}
  s.email = %q{dave.myron@contentfree.com}
  s.files = ["VERSION.yml", "lib/sneaky_sender.rb", "spec/sneaky_sender_spec.rb", "spec/spec_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/contentfree/sneaky_sender}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Use multiple email accounts to send large numbers of email. Sneaky!}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
