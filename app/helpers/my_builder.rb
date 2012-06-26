class MyBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @elements.collect do |element|
      render_element(element)
    end.join(@options[:separator] || " &raquo; ")
  end

  def render_element(element)
    content = @context.link_to_unless_current(compute_name(element), compute_path(element), class: "label label-info", style: "color:white;margin-left:2px" )
    if @options[:tag]
      @context.content_tag(@options[:tag], content)
    else
      content
    end
  end

end
