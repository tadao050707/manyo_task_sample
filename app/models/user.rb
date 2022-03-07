class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  after_update :prevent_changing_admin
  after_destroy :prevent_removing_admin

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  private

  def prevent_changing_admin
    return if self.class.where(admin: true).exists?
    errors.add(:base, I18n.t('errors.messages.prevent_changing_admin'))

    raise ActiveRecord::Rollback, self
  end

  def prevent_removing_admin
    return if self.class.where(admin: true).exists?
    raise ActiveRecord::Rollback
  end
end
