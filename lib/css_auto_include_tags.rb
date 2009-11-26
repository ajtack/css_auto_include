module ActionView
	module Helpers
		module AssetTagHelper

			# Creates a script tag which loads the correct stylesheet for the controller and
			# template in use. Given a GET /books, using template 'index', this will include
			# all of the following (if they exist):
			#   - /stylesheets/application.css
			#   - /stylesheets/books.css
			#   - /stylesheets/books/index.css
			#
			# Note that the last of these included stylesheets will be matched per the template
			# rendered, not per the action requested (though they may often be the same.)
			def css_auto_include_tags
				# Define the names of the different possible stylesheets for this controller and template.
				applicationCss = 'application.css'
				controllerCss = "#{controller.controller_path}.css"
				viewCss = lambda do
					templatePath = response.template.instance_variable_get(:@_first_render).path
					directory = File.dirname(templatePath)
					file = File.basename(templatePath, '.html.erb')
					File.join(directory, file + '.css')
				end.call
				        
				# Include the stylesheets that exist in public/stylesheets.
				[applicationCss, controllerCss, viewCss].collect do |path|
					if File.exist?(File.join(RAILS_ROOT, 'public', 'stylesheets', path))
						stylesheet_link_tag path
					end
				end.join("\n")
			end

		end
	end
end
