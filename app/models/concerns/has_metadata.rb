# app/models/concerns/has_metadata.rb
module HasMetadata
  extend ActiveSupport::Concern

  class_methods do
    def metadata_keys(*keys)
      @declared_metadata_keys = keys.map(&:to_s)

      keys.each do |key|
        define_method(key) do
          metadata[key.to_s]
        end

        define_method("#{key}=") do |value|
          self.metadata ||= {}
          self.metadata[key.to_s] = value
        end
      end
    end

    def declared_metadata_keys
      @declared_metadata_keys || []
    end
  end

  # Optional: validate declared keys exist
  included do
    validate :validate_required_metadata_keys
  end

  private

  def validate_required_metadata_keys
    required_keys = self.class.declared_metadata_keys
    return if required_keys.blank?

    required_keys.each do |key|
      if metadata[key.to_s].blank?
        errors.add(:metadata, "#{key} is required")
      end
    end
  end
end
