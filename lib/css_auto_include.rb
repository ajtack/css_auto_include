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
			def css_auto_include_tag
				applicationCss = 'application.css'
				controllerCss = "#{controller.controller_name}.css"
				templateName = @_first_render.to_s
				viewCss = File.join(templateName[0...templateName.index(/\.html\.erb\z/)] + '.css')
        
				[applicationCss, controllerCss, viewCss].collect do |path|
					if File.exist?(File.join(RAILS_ROOT, 'public', 'stylesheets', path))
						stylesheet_link_tag path
					end
				end.join
			end

		end
	end
end