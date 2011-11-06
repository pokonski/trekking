module ApplicationHelper
  def navigation(elements)
    html = ""
    for element in elements
      html << content_tag(:li, link_to(element[0], element[1]), :class => (request.path == element[1] ? "active" : ""))
    end
    return html.html_safe
  end
end
