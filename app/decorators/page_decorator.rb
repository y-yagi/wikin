# coding: utf-8
module PageDecorator
  def link
    link_to(title, to_url)
  end

  def full_title(with_link: false)
    return title if ancestors.empty?

    ActiveDecorator::Decorator.instance.decorate(ancestors)
    if (with_link)
      all_title = ancestors.map(&:link).reverse.join(' / ')
    else
      all_title = ancestors.map(&:title).reverse.join(' / ')
    end
    all_title += ' / '  + title
    all_title.html_safe
  end

  def full_title_without_self
    return '' if ancestors.empty?

    ActiveDecorator::Decorator.instance.decorate(ancestors)
    ancestors.map(&:title).reverse.join(' / ')
  end

  def to_url
    "#{request.protocol}#{request.host_with_port}#{to_path}"
  end
end
