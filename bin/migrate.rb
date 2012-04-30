#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'yaml'
require 'dm-migrations'

begin
  @@conf = YAML::load open(File.dirname(__FILE__)+'/../config.yaml').read
  p @@conf
rescue => e
  STDERR.puts 'config.yaml load error!'
  STDERR.puts e
  exit 1
end

[:inits, :models].each do |dir|
  Dir.glob(File.dirname(__FILE__)+"/../#{dir}/*.rb").each do |rb|
    puts "loading #{rb}"
    require rb
  end
end

DataMapper.auto_migrate!
DataMapper.auto_upgrade!
