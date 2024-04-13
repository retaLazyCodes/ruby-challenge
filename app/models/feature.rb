class Feature < ApplicationRecord
    validates :title, presence: true
    validates :url, presence: true
    validates :place, presence: true
    validates :mag_type, presence: true
    validates :coordinates, presence: true
    validates :magnitude,
            numericality: {
              greater_than_or_equal_to: -1.0,
              less_than_or_equal_to: 10.0
            }
    validate :validate_coordinates_schema

  private

  def validate_coordinates_schema
    return unless coordinates.present?
    
    schema_path = Rails.root.join('coordinates_schema.json')
    
    unless File.exist?(schema_path)
      errors.add(:coordinates, 'schema file not found')
      return
    end
    
    schema = File.read(schema_path)
    validator = JSON::Validator.new(schema)
    
    unless validator.validate(JSON.dump(coordinates))
      errors.add(:coordinates, 'is invalid')
      errors.add(:coordinates, validator.errors.join(', '))
    end
  rescue JSON::Schema::ValidationError => e
    errors.add(:coordinates, "doesn't match schema: #{e.message}")
  end
end
