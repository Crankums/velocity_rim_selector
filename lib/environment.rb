require 'pry'
require 'nokogiri'
require 'open-uri'
require "cli_project/version"

module CliProject
  class Error < StandardError; end
  # Your code goes here...
end

require './scraper'