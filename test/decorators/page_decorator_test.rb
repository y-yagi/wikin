require 'test_helper'

class PageDecoratorTest < ActiveSupport::TestCase
  def setup
    @page = Page.new.extend PageDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
