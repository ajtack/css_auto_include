module ActionView
	module Helpers
		module AssetTagHelper

			# Creates a script tag which loads the correct Javascript file (if one exists) according to the Rails view template conventions
			# For example if you're on the users controllers show action, it tries to load app/views/users/show.js.erb
			def css_auto_include_tag
				controllerCss = File.join("#{controller.controller_name}.css")
				templateName = @_first_render.to_s
				viewCss = File.join(templateName[0...templateName.index(/\.html\.erb\z/)] + '.css')
        
				[controllerCss, viewCss].collect do |path|
					if File.exist?(File.join(RAILS_ROOT, 'public', 'stylesheets', path))
						stylesheet_link_tag path
					end
				end.join
			end

		end
	end
end