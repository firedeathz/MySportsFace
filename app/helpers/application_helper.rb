module ApplicationHelper
 # Returns the full title of a page
 def full_title(page_title = '')
    base_title = "MySportsFace"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
end
