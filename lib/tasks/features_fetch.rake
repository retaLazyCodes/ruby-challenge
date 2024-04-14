namespace :features do
  desc "Fetch recent features data"
  task fetch: :environment do
    require 'faraday'
    require 'json'

    url = EarthquakeAPI::BASE_URL
    conn = Faraday.new(url: url)

    puts "Obteniendo datos de la url: " + url

    response = conn.get
    data = JSON.parse(response.body)

    data['features'].each do |feature|
      properties = feature['properties']
      geometry = feature['geometry']

      next if Feature.exists?(external_id: feature['id'])

      magnitude = properties['mag']
      latitude = geometry['coordinates'][1]
      longitude = geometry['coordinates'][0]

      Feature.create(
        external_id: feature['id'],
        magnitude: magnitude,
        place: properties['place'],
        time: Time.at(properties['time'] / 1000),
        url: properties['url'],
        tsunami: properties['tsunami'],
        mag_type: properties['magType'],
        title: properties['title'],
        coordinates: { longitude: longitude, latitude: latitude },
      )
    end

    puts "Datos de terremotos del feed guardados en la base de datos."
  end
end
