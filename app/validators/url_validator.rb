class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.length == 1
      record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value[0])
    elsif value.length > 1
      for i in 0..(value.length - 1)
        record.errors[attribute] << (options[:message] || "must be a valid URL") unless url_valid?(value[i])
      end
    end
  end

  def url_valid?(url)
    url = URI.parse(url) rescue false
    url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
  end
end