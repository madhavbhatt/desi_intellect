module ApplicationHelper
	#use for page title
	def full_title(page_title = '')
		base_title = "Bank of Bogus Transactions"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end
end
