module ApplicationHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options={})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=404"
    gravatar_class = options[:class].blank? ? "gravatar" : options[:class]
    unless options[:size].blank?
      gravatar_url << "&s=%d"%options[:size]
    end
    image_opts={alt: user.email , class: gravatar_class, onload: "javascript: $('#glyph-#{gravatar_class}-#{gravatar_id}').hide(); $('#gravatar-#{gravatar_class}-#{gravatar_id}').show();".html_safe}
    unless options[:tooltip].blank?
      image_opts.merge! rel: 'tooltip', title: options[:tooltip]
    end
    content_tag('div', tag('span', class: "glyphicon glyphicon-user glyph-#{gravatar_class}", "aria-hidden" => "true"), id: "glyph-#{gravatar_class}-#{gravatar_id}", class: "box-#{gravatar_class}")+content_tag('span', image_tag(gravatar_url, image_opts), style: 'display:none', id: "gravatar-#{gravatar_class}-#{gravatar_id}", "aria-hidden" => "true")
  end

  def full_title(page_title)
    base_title = I18n.t('site.short_title')
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

end
