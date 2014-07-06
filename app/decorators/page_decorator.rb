# coding: utf-8
module PageDecorator
  def link
    link_to(title, to_url)
  end

  def page_title
    return title if ancestors.empty?

    ActiveDecorator::Decorator.instance.decorate(ancestors)

    all_title = ancestors.map(&:link).join(' / ')
    all_title += ' / '  + title
    all_title.html_safe
  end

  def to_url
    "#{request.protocol}#{request.host_with_port}#{to_path}"
  end
end
