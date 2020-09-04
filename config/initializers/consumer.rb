channel = RabbitMq.consumer_channel
queue = channel.queue("geocoding", durable: true)
exchange = channel.default_exchange

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON.parse(payload)
  lat, lon = Geocoder.geocode(payload["city"])

  exchange.publish(
      {lat: lat, lon: lon}.to_json,
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
  )


end
