class Customer < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :phone, presence: true, format: { with: /\A(([0-9][\- ]{1}|\+7[\- ]?|\+\d{3}|)[\- ]?)?(\(?\d{1,8}\)?[\- ]?)?[\d\- ]{5,10}\Z/, message: "phone format +7 916 1113344" }

  validates :phone, uniqueness: true

  scope :available, -> { where(blacklisted: false) }
  scope :blocked, -> { where(blacklisted: true) }

  def to_blacklist!
    self.blacklisted = true
    save
  end

  def blacklist_off!
    self.blacklisted = false
    save
  end

  def black?
    blacklisted
  end

  def self.search(phone)
    available.where(phone: phone.strip).first
  end
end

