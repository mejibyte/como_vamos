#require File.join(File.dirname(__FILE__), "lib", "make_permalink")
require 'make_permalink'

if Object.const_defined?("ActiveRecord")
  ActiveRecord::Base.send(:include, MakePermalink)
end
