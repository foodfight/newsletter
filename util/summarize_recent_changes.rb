require 'rubygems'
require 'mongo'
require 'json'
require 'net/http'
require 'pp'

@con = Mongo::Connection.new
@db = @con['opscode']
@cookbooks = @db['cookbooks']

number_cookbooks_last_edition = 1075
number_cookbooks_now = 1087
number_new_cookbooks = number_cookbooks_now - number_cookbooks_last_edition

lastest_cookbooks = @cookbooks.find.sort( [["created_at", -1 ]] ).limit(number_new_cookbooks)
new_cookbooks = []
new_cookbook_urls = []
new_cookbook_summary = []
last_book = ""

lastest_cookbooks.each do |cb|
  maintainer = cb["cookbook_maintainer"]
  description = cb["description"]
  updated_at = cb["updated_at"]
  name = cb["name"]
  cookbook_url = "http://community.opscode.com/cookbooks/#{name}" 
  maintainer_url = "http://community.opscode.com/users/#{maintainer}"
  latest_version = cb["versions"][0].split("/").pop.gsub("_",".")
  new_cookbooks << name
  new_cookbook_urls << cookbook_url
  
  if last_book == ""
    last_book = "last_book is #{name} #{latest_version}"
  end

  new_cookbook_summary << "* [#{name}](#{cookbook_url}) - [#{maintainer}](#{maintainer_url}) - #{description}"
end

new_cookbook_summary.sort!
new_cookbook_summary.each do |new_cookbook|
  puts new_cookbook
end

updated_cookbook_summary = []
updated_cookbooks = @cookbooks.find.sort( [["updated_at", -1 ]] ).limit(number_new_cookbooks * 10)
last_updated_cookbooks = []

updated_cookbooks.each do |cb|
  if !new_cookbooks.include?(cb["name"])
    name = cb["name"]
    cookbook_url = "http://community.opscode.com/cookbooks/#{name}" 
    latest_version = cb["versions"][0].split("/").pop.gsub("_",".")
    updated_cookbook_summary << "* [#{name}](#{cookbook_url}) - (#{latest_version})"
    if last_updated_cookbooks.size < 3 
      last_updated_cookbooks << "#{name} #{latest_version}"
    end
  end
end

updated_cookbook_summary.sort!
updated_cookbook_summary.each do |updated_cookbook|
  puts updated_cookbook
end

new_cookbook_urls.sort.each do |url|
  puts "open #{url}"
end

puts last_book
last_updated_cookbooks.each do |last_updated|
  puts last_updated
end
