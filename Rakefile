require "rake"
begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name              = "preposterous"
    gem.summary           = %Q{wrapper for the posterous api}
    gem.email             = "hernan43@gmail.com"
    gem.homepage          = "http://github.com/hernan43/preposterous"
    gem.authors           = ["Ray Hernandez"]
    gem.files             = FileList["[A-Z]*", "{examples,lib}/**/*"]

    gem.add_dependency("httparty", ">= 0.5.2")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

Jeweler::GemcutterTasks.new
