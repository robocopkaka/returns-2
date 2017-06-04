json.extract! payment, :id, :merchantId, :serviceTypeId, :orderId, :payerName, :payerEmail, :payerPhone, :amount, :reference, :created_at, :updated_at
json.url payment_url(payment, format: :json)