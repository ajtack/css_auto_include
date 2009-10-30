require 'rendered_templates'

#
# Monkey-patches the render function (render_for_file) which is called to render
# a template. The new version stores the template being rendered in the 
# rendered_templates attribute of the active response object. This array of
# templates can be extracted at arbitrary points.
#
# Specific repercussions of rendered_templates include:
#   - response.rendered_templates.first is the primary template, rendered by the
#     "yield" instruction in a layout.
#   - response.rendered_templates.last is always the currently-rendered template.
#
module CssAutoInclude
	def self.included(base)
		base.extend(ClassMethods)
	end
	
	module ClassMethods
		def activate_css_auto_include
			# Capture an unbound instance of the render_for_file method.
			render_for_file = self.new.method(:render_for_file).unbind
			
			# Create a replacement render_for_file function. Note that template_path
			# is the only required parameter of the original render_for_file.
			_render_for_file = Proc.new do |template_path, *others|
				# Stash the template being rendered.
				@_response.rendered_templates << template_path
				
				# Capture all the optional variables and make the call to the original
				# render_for_file function. Note that self is a controller instance.
				status, layout, locals, = *others
				locals ||= {}
				render_for_file.bind(self).call(template_path, status, layout, locals)
			end
			
			# Replace the original render_for_file function with our new version.
			define_method(:render_for_file, _render_for_file)
		end
	end
end
