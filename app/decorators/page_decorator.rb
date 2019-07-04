# typed: true
module PageDecorator
  def link
    link_to(title, to_url)
  end

  def full_link
    return title if ancestors.empty?

    ActiveDecorator::Decorator.instance.decorate(ancestors)
    (ancestors.map(&:link).reverse.join(' / ') + ' / ' + title).html_safe
  end

  def to_url
    "#{request.protocol}#{request.host_with_port}#{to_path}"
  end
end
