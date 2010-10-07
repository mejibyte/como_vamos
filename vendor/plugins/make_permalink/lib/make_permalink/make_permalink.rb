module MakePermalink
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    # Creates a permalink for a given object based on the attribute passed as
    # parameter.
    #
    # The good thing about this is that you don't need a column in the model's table
    # to store the permalink.
    # 
    # 
    # Example:
    #    
    #   class Post < ActiveRecord::Base
    #     make_permalink :title
    #   end
    #
    #   p = Post.create(:title => "Hello World!")
    #   p.permalink   # => "1-hello-world"
    def make_permalink(method, options = {})
      define_method "permalink" do

        default_options = { :replace_nonascii => true }
        default_options.merge!(options)
        field = self.send(method.to_sym)
        if default_options[:replace_nonascii]
          link = "#{id}-#{field.to_s.to_url.downcase}"
        else
          link = "#{id}-#{field.gsub(/[^\w]+/,"-").downcase}"
        end
        link.gsub(/-$/, "")
        
      end
    end
  end
end







