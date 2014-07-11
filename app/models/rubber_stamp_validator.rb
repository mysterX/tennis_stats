class RubberStampValidator < ActiveModel::Validator
  def validate(record)
    # Everything is allowed, unlike parent class
  end
end
