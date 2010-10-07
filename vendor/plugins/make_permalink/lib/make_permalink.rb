require 'make_permalink/acts_as_url'
require 'make_permalink/string_extensions'
require 'make_permalink/unidecoder'
require 'make_permalink/make_permalink'

String.send :include, LuckySneaks::StringExtensions

if defined?(ActiveRecord)
  ActiveRecord::Base.send :include, MakePermalink
  ActiveRecord::Base.send :include, LuckySneaks::ActsAsUrl
end
