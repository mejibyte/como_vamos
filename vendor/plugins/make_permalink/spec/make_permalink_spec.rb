# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + "/spec_helper"

describe "MakePermalink" do
  it "creates a permalink for a field" do
    Thingie.new("foo").permalink.should == "1-foo"
    
    t = Thingie.new("foo*.,/\<>%&[]{}bar")
    t.permalink.should == "1-foo-bar"
    
    t = Thingie.new("It's-a-me, Mario!    ")
    t.permalink.should == "1-it-s-a-me-mario"
  end

  it "fails if the field is not defined" do
    lambda { bad = BadThingie.new; bad.permalink }.should raise_error
  end
  
  it "creates a permalink from nonascii chars" do
    #Thingie.new("mateMáticas").permalink.should == "1-matematicas"
    t = Thingie.new("mateMáticas")
    t.permalink.should == "1-matematicas"
    
    t = Thingie.new("fooñÑá[]bar")
    t.permalink.should == "1-foonna-bar"
    
    t = Thingie.new("It's-a-me, Mario!")
    t.permalink.should == "1-it-s-a-me-mario"
  end
  
  class Thingie
    include MakePermalink
    attr_reader :a, :id
    make_permalink :a
    
    def initialize(value)
      @a = value; @id = 1
    end
  end

  class BadThingie
    include MakePermalink
    make_permalink :i_dont_exist
  end
end
