# frozen_string_literal: true

require 'puppet_litmus'
require 'singleton'
require 'pp'

class Helper
  include Singleton
  include PuppetLitmus
end
