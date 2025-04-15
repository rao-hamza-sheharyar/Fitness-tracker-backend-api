class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  before_create :generate_confirmation_token
  has_many :diet_plans, dependent: :destroy



  def confirm!
    update_columns(confirmed_at: Time.current, confirmation_token: nil)
  end

  def confirmed?
    confirmed_at.present?
  end


  def admin?
    role == "admin"
  end

  private

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64
  end
end
