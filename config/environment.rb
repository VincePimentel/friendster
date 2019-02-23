# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Prevent forms from breaking styling when an error occurs
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    class_index = html_tag.index('class="')
    first_tag_index = html_tag.index('>')

    if class_index.nil? || class_index > first_tag_index
      html_tag.insert(first_tag_index, ' class="error"')
    else
      html_tag.insert(class_index + 7, 'error ')
    end
end
