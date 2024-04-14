json.data @features do |feature|
  json.id feature.id
  json.type 'feature'
  json.attributes do
    json.external_id feature.external_id
    json.magnitude feature.magnitude
    json.place feature.place
    json.time feature.time
    json.tsunami feature.tsunami
    json.mag_type feature.mag_type
    json.title feature.title
    
    if feature.coordinates.present?
      json.coordinates do
        json.latitude feature.coordinates['latitude']
        json.longitude feature.coordinates['longitude']
      end
    end
  end


  json.links do
    json.external_url feature.url
  end
end


json.pagination do
  json.current_page @current_page
  json.total @total
  json.per_page @per_page
end