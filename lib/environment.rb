require 'nokogiri'
require 'open-uri'
require "cli_project/version"
require 'pry'

module CliProject
  class Error < StandardError; end
  # Your code goes here...
end

require_relative './scraper'