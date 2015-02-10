module AdminHelper
  def phone_tag(phone)
    link_to phone, "tel://#{phone.gsub(/[\(\)\- ]/, '')}"
  end
end