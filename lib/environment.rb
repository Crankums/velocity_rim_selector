require 'nokogiri'
require 'open-uri'
require_relative "./cli_project/version"
# require 'pry'

module CliProject
  class Error < StandardError; end
  # Your code goes here...
end

require_relative './findable'
require_relative './scraper'
require_relative './command_line_interface'
require_relative './application'
require_relative './rim'