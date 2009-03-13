ActionController::Response.class_eval do	
	
	# This attribute is an array of rendered templates. We do lazy
	# initialization here to avoid method aliasing of the constructor.
	def rendered_templates
		@rendered_templates ||= Array.new
	end
	
end
