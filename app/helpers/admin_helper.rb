module AdminHelper
  def phone_tag(phone)
    link_to phone, "tel://8#{phone.gsub(/[\(\)\- ]/, '')}"
  end
end