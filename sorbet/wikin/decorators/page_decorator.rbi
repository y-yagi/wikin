module PageDecorator
  include Page::InstanceMethods
  include ActionView::Helpers::UrlHelper
  include Edge::Forest::InstanceMethods

  def request; end
end
