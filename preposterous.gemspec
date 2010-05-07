# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{preposterous}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ray Hernandez"]
  s.date = %q{2010-05-07}
  s.description = %q{This gem supports posting and listing sites on Posterous}
  s.email = %q{hernan43@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION.yml",
     "examples/.gitignore",
     "examples/post.rb",
     "lib/preposterous.rb",
     "lib/preposterous/base.rb",
     "lib/preposterous/httpauth.rb",
     "lib/preposterous/request.rb"
  ]
  s.homepage = %q{http://github.com/hernan43/posterous}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{a wrapper library for the Posterous API}
  s.test_files = [
    "examples/post.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

