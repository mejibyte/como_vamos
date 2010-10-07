# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + "/spec_helper"

describe "MakePermalink" do
  
  
  it "creates a permalink with just AlphaNumeric characters" do
    t = NonAsciiPermalinks.new("foo*.,/\<>%&[]{}bar")
    t.permalink.should == "1-foo-bar"
    
    t = NonAsciiPermalinks.new("It's-a-me, Mario!    ")
    t.permalink.should == "1-it-s-a-me-mario"
    
    t = NonAsciiPermalinks.new("It's-a-me, $10 Mario!") #Notice the $ sign
    t.permalink.should == "1-it-s-a-me-10-mario"
    
    t = NonAsciiPermalinks.new("Let's rock & roll") #Notice the & sign
    t.permalink.should == "1-let-s-rock-roll"
    
    t = NonAsciiPermalinks.new("This.should.remove.the.dots..")
    t.permalink.should == "1-this-should-remove-the-dots"
    
    t = NonAsciiPermalinks.new("Simple English Text")
    t.permalink.should == "1-simple-english-text"
  end

  it "fails if the field is not defined" do
    lambda { bad = BadThingie.new; bad.permalink }.should raise_error
  end
  
  it "creates a permalink from nonascii chars" do
    t = Thingie.new("Simple English Text")
    t.permalink.should == "1-simple-english-text"
    
    t = Thingie.new("mateMáticas")
    t.permalink.should == "1-matematicas"
    
    t = Thingie.new("fooñÑá[]bar")
    t.permalink.should == "1-foonna-bar"
    
    t = Thingie.new("It's-a-me, Mario!")
    t.permalink.should == "1-its-a-me-mario"
    
    t = Thingie.new("Its-a-me, Mario!")
    t.permalink.should == "1-its-a-me-mario"
  end
  
  it "should change nonascii symbols to words" do
    t = Thingie.new("6 pack for $10")
    t.permalink.should == "1-6-pack-for-10-dollars"
    
    t = Thingie.new("Let's Rock & Roll")
    t.permalink.should == "1-lets-rock-and-roll"
    
    t = Thingie.new("Sex & Drugs & Helvetica Bold")
    t.permalink.should == "1-sex-and-drugs-and-helvetica-bold"
  end
  
  class NonAsciiPermalinks
    include MakePermalink
    attr_reader :a, :id
    make_permalink :a, :replace_nonascii => false
    def initialize(value)
      @a = value; @id = 1
    end
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
