require 'rubygems'
require 'em-websocket'
require 'json'
require 'haml'
require 'sinatra'
require 'sinatra/base'
require 'thin'
require 'logger'

require './game.rb'
require './player.rb'
require './diceset.rb'

Dir.mkdir('logs') unless File.exist?('logs')

$log = Logger.new('logs/output.log','weekly')

configure :development do
  $log.level = Logger::DEBUG
end

configure :production do
  $log.level = Logger::WARN
end
