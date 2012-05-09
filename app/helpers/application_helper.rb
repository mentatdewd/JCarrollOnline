module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "JCarrollOnline"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  def safe_image_tag(source, options = {})
    source ||= "default.jpg"
    image_tag(source, options)
  end
end