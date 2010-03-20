require 'iconv'

module MakePermalink
  def self.included(base)
    base.extend ClassMethods
  end
end

module ClassMethods
  # Creates a permalink for a given object based on the attribute passed as
  # parameter:
  #     
  #   class Post < ActiveRecord::Base
  #     make_permalink :title
  #   end
  #
  #   p = Post.create(:title => "Hello World!")
  #   p.permalink   # => "1-hello-world"
  def make_permalink(method)
    define_method "permalink" do 
      field = self.send(method.to_sym)
      
      link = "#{field.gsub(/[á]/, "a").downcase}"
      link = "#{link.gsub(/[é]/, "e").downcase}"
      link = "#{link.gsub(/[í]/, "i").downcase}"
      link = "#{link.gsub(/[ó]/, "o").downcase}"
      link = "#{link.gsub(/[ú]/, "u").downcase}"
      link = "#{link.gsub(/[Á]/, "a").downcase}"
      link = "#{link.gsub(/[É]/, "e").downcase}"
      link = "#{link.gsub(/[Í]/, "i").downcase}"
      link = "#{link.gsub(/[Ó]/, "o").downcase}"
      link = "#{link.gsub(/[ú]/, "u").downcase}"
      link = "#{link.gsub(/[ñ]/, "n").downcase}"
      link = "#{link.gsub(/[Ñ]/, "n").downcase}"
      link = "#{link.gsub(/[^a-zA-Z0-9]+/, "-").downcase}"
      #link.gsub(/-$/, "")       # remove trailing dashes
      [id,link.gsub(/-$/, "")].join("-")
      
      
      #result = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', field.to_s).to_s
      #link = "#{id}"
      #link = "#{id}-#{result.gsub(/[^\w]+/, " ").to_a.join("-").downcase}"
      #puts "result is = #{result}"
      #result.split.each do |t|
      #  link = [link,t.gsub(/[^a-zA-Z0-9]+/, "").downcase].join("-")
      #end
      
      #link = "#{id}-#{result.downcase}"
      #link.gsub(/-$/, "")       # remove trailing dashes
      #result.gsub(/-$/, "")
    end
  end
end





