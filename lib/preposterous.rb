module Preposterous
end

# bring inall of the files in the lib dir
directory = File.expand_path(File.dirname(__FILE__))
require File.join(directory, "preposterous", "base")

