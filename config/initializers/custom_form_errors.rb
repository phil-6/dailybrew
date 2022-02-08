ActionView::Base.field_error_proc = proc do |html_tag, instance|
  debugger
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at('input,select,textarea')
  error_messages = instance.object.errors.messages

  html = nil
  if field
    field['class'] = "#{field['class']} invalid"

    value = field.attributes['name']
                  .value
                  .match(/\[(.*?)\]/)[0]
                  .delete('[]')

    error_message = error_messages[value.to_sym].last
    error_message = 'is invalid' unless error_message.present?

    html = <<HTML
      #{fragment.to_s} 
      <span class=\"error-message\">
        #{value.gsub('_', ' ').capitalize} #{error_message}
      </span>
HTML

    html
  else
    html = html_tag
  end

  html.html_safe
end
