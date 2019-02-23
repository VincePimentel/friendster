module ApplicationHelper

  def flash_message
    message = ""

    flash.each do |key, value|
      message = tag.div class: "alert alert-#{key}" do
        value
      end
    end

    message
  end
end
