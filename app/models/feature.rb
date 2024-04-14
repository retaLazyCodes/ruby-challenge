class Feature < ApplicationRecord
  include Kaminari::PageScopeMethods

  has_many :comments, dependent: :destroy

  validates_presence_of :title, :url, :place, :mag_type, :coordinates
  validates :magnitude,
            numericality: {
              greater_than_or_equal_to: -1.0,
              less_than_or_equal_to: 10.0
            }
  validate :validate_coordinates_schema

  def as_json(options = nil)
    if options && options[:include_comments]
      super(include: {
        comments: {
          except: [:id, :feature_id, :created_at, :updated_at]
        }
      })
    else
      super()
    end
  end

  private

  def validate_coordinates_schema
    return unless coordinates.present?
    
    schema_path = Rails.root.join('app', 'models', 'coordinates_schema.json')
    
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
