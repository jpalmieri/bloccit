module ApplicationHelper
  def my_name
    "Joe Palmieri"
  end

  def my_email
    "jpalmieri@lumoslabs.com"
  end

  def form_group_tag(errors)
    if errors.any?
      'has-error'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true, strikethrough: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end
end
