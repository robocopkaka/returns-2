module PaymentsHelper
	mid = Rails.application.secrets.remita_merchant_id.to_s
    sid = Rails.application.secrets.remita_service_type_id.to_s
    akey = Rails.application.secrets.remita_api_key.to_s
    puts "mid: #{mid}, sid: #{sid}, akey: #{akey}"
    Digest::SHA512::hexdigest(mid + sid + order_id.to_s + amt.to_s + url + akey)
end
