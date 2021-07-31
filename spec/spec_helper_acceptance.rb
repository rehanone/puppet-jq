# frozen_string_literal: true

require 'beaker-rspec'
require 'beaker-puppet'

require 'puppet_litmus'
require 'spec_helper_acceptance_local' if File.file?(File.join(File.dirname(__FILE__), 'spec_helper_acceptance_local.rb'))

include PuppetLitmus
PuppetLitmus.configure!
