module ApplicationHelper
 def javascript(url)
      content_for :javascript do
        javascript_include_tag url
      end
 end
end
