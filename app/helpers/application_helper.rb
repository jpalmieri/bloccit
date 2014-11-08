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
end
