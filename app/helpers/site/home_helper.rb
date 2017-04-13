module Site::HomeHelper

	def first_carousel?(carousel, ad)
		if carousel.first.id == ad.id
			"active"
		end
	end
end
