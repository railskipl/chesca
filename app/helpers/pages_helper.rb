module PagesHelper
  def link_to_pages
    results = []
    Page.all.each do |page|
      results << content_tag(:p, link_to(page.name.upcase, page_path(page), :class => 'black'),:class => 'bold')
    end
    results.join(content_tag(:br))
  end
end
