module ApplicationHelper

  def u2f
    # use base_url as app_id, e.g. 'http://localhost:3000'
    @u2f ||= U2F::U2F.new(request.base_url)
  end
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options={})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    img_id = options[:id].blank? ? '0' : options[:id]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=404"
    gravatar_class = options[:class].blank? ? "gravatar" : options[:class]
    unless options[:size].blank?
      gravatar_url << "&s=%d"%options[:size]
    end
    image_opts={alt: user.email , class: gravatar_class, onload: "javascript: $('#glyph-#{gravatar_class}-#{gravatar_id}-#{img_id}').hide(); $('#gravatar-#{gravatar_class}-#{gravatar_id}-#{img_id}').show();".html_safe}
    unless options[:tooltip].blank?
      image_opts.merge! rel: 'tooltip', title: options[:tooltip]
    end
    content_tag('div', tag('span', class: "glyphicon glyphicon-user glyph-#{gravatar_class}-#{img_id}", "aria-hidden" => "true"), id: "glyph-#{gravatar_class}-#{gravatar_id}-#{img_id}", class: "box-#{gravatar_class}")+content_tag('span', image_tag(gravatar_url, image_opts), style: 'display:none', id: "gravatar-#{gravatar_class}-#{gravatar_id}-#{img_id}", "aria-hidden" => "true")
  end

  def full_title(page_title)
    base_title = I18n.t('site.short_title')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def option_value(value, default)
    value ? value : default
  end

  def settings_row(head, subline, options={}, &block) 
    decorate = option_value(options[:decorate], "")
    width = option_value(options[:width], "9")
    content_tag(:div, class: 'row') do
      content_tag(:div, class: 'col-lg-3') do
        content_tag(:h3, head, class: "#{decorate}") +
        content_tag(:p, subline, class: "text-muted #{decorate}")
      end + 
      content_tag(:div, class: "col-lg-#{width}") do
        yield
      end
    end
  end
end
