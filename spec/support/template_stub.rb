require 'action_view/helpers'

class TemplateStub
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::FormTagHelper

  attr_accessor :output_buffer

  def initialize
    @output_buffer = ""
  end

  def concat obj
    @output_buffer += obj.to_s
  end

  def to_s
    @output_buffer
  end

  def translate *keys
    '.' + keys.map(&:to_s).join('.') + '.'
  end
end
