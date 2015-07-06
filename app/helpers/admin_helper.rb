module AdminHelper
  def phone_tag(phone)
    link_to phone, "tel://#{phone.gsub(/[\(\)\- ]/, '')}"
  end

  def link_finder(text)
    text.gsub(/(https?:\/\/[\S]+)/, '<a href="\1" target="_blank">link</a>')
  end
end