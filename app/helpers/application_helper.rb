module ApplicationHelper
  def page_header(title, &block)
    <<-HTML.html_safe
    <div class="page-header">
      #{capture(&block) if block_given?}
      <h1>#{h(title)}</h1>
    </div>
    HTML
  end

  def buttons_page_header(title, &block)
    page_header(title) do
      content_tag(:div, class: "pull-right", &block)
    end
  end

  def glyphicon(kind, white=false)
    klass = "icon-#{kind}"
    klass << " icon-white" if white
    %(<i class="#{klass}"></i>).html_safe
  end

  def glyph_button_to(icon, text, path, options={})
    link_to glyphicon(icon, true) << " #{text}", path, { class: "btn btn-primary" }.merge!(options)
  end

  def alert_message(klass, message)
    return if message.blank?

    <<-HTML.html_safe
      <div class="alert alert-#{klass}">
        <a class="close" data-dismiss="alert" href="#">x</a>
        #{message}
      </div>
    HTML
  end

  def flash_messages
    flash.map do |kind, message|
      css = case kind
            when :notice then 'success'
            when :alert  then 'error'
            end

      alert_message css, message
    end.compact.join.html_safe
  end

  def icon_tag(type, options = {})
    css = Array(options[:class])
    css << "icon-#{type}"
    content_tag :i, nil, options.merge(class: css)
  end

  def nav_item(text, url_options)
    css = 'active' if current_area?(url_options)
    content_tag :li, link_to(text, url_options), class: css
  end

  def boolean_label(value)
    value ? 'Sim' : 'Não'
  end

  private

  def current_area?(path)
    if path == root_path
      request.path == path
    else
      request.path.start_with?(path)
    end
  end
end
