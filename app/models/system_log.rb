class SystemLog < ActiveRecord::Base
  validates :comment, presence: true

  def self.log(aString)
    log = SystemLog.new(comment: aString)
    log.save
    log
  end
end
