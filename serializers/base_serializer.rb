module Domain
  class BaseSerializer
    include JSONAPI::Serializer

    def format_name(attribute_name)
      attribute_name.to_s.underscore
    end

    def self_link
      nil
    end
  end
end
