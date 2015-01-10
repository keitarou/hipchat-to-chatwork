# coding: utf-8

require 'yaml'
require 'pp'
require 'uri'
require 'net/http'
require 'json'

require 'daemons'


$config = YAML.load_file('./config.yml')

Daemons.run('./main_loop.rb')
