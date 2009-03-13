require 'css_auto_include'
require 'css_auto_include_tags'

ActionController::Base.send(:include, CssAutoInclude)
