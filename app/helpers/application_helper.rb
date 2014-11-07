module ApplicationHelper
  def my_name
    "Joe Palmieri"
  end

  def my_email
    "jpalmieri@lumoslabs.com"
  end

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end
end
