require 'rubygems'
require File.join(File.dirname(__FILE__), '..', 'lib', 'preposterous')

#
# creating a posterous object
#

# all requests need to be authenticated
# this creates your client object and sets up 
# your posterous object for actions
client = Preposterous::HTTPAuth.new("my@email.addre.ss", "password")
posterous = Preposterous::Base.new(client)

#
# get and print a list of your posterous sites
#
posterous.getsites.each do |site|
  puts "#{site['id']} #{site['url']}"
end

#
# standard post w/no files
#

# initialize the fields
# field names are here: http://posterous.com/api/posting
fields = {
  :site_id => 99999999,
  :title => "This is my post",
  :body => "This is some boring text for my autogenerated post."    
}

# perform the actual post
posterous.newpost(fields, *files)

#
# standard post w/files
#

# initialize array of files
files = [
  File.open("file_one.png"),
  File.open("file_two.png")
]

# initialize fields
fields = {
  :site_id => 1313830,
  :title => "Check out these sweet pics",
  :body => "I love these pics."    
}

# perform the actual post
posterous.newpost(fields, *files)

#
# update post w/files
#

# initialize array of files
files = [
  File.open("examples/three.png"),
  File.open("examples/four.png")
]

# initialize fields
fields = {
  :post_id => 18195104,
  :title => "Autogenerated post from Preposterous Gem [#{Time.now}]",
  :body => "This is some new text for my autogenerated post."    
}

# perform the update
posterous.updatepost(fields, *files)

#
# fetch the tags from your site
#

puts posterous.gettags
