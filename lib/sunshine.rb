#--
# Copyright (c) 2009 Justin Palmer
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))


module Sunshine
  # def self.included(base)
  #   base.send :include, ModuleLevelInheritableAttributes
  #   base.send(:mattr_inheritable, :keys_to_exclude)
  #   base.instance_variable_set("@keys_to_exclude", [])
  # end
  # def self.included(base)
  #   base.extend
  # end
  # Set your Sunlight API key.
  #
  def api_key=(key)
    @api_key = key
  end
  module_function :api_key=
  
  # Get the API key.
  def api_key
    @api_key
  end
  module_function :api_key
  
  
  VERSION = '0.1.0'
end
  
require 'sunshine/base'
require 'sunshine/district'
require 'sunshine/legislator'
require 'sunshine/disclosure_filing'
require 'sunshine/lobbyist'