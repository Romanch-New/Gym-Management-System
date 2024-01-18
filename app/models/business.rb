class Business < ApplicationRecord
  belongs_to :admin, class_name: "User", foreign_key: "user_id", inverse_of: :businesses
  # has_many :invitations, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :business_type, presence: true
  validate :user_is_admin

  scope :business, -> { where(business_type: 0) }
  scope :personal, -> { where(business_type: 1) }

  enum business_type: { business: 0, personal: 1 }

  # def invite_user(email, roles)
  #   invitation = Invitation.new(email: email, roles: roles, business_id: self.id)
  #   invitation.save
  #   # Here you can add the code to send the invitation email.
  #   # The email should contain a link to the `accept` action of `InvitationsController`,
  #   # with the invitation token as a parameter.
  # end

  private

  def user_is_admin
    # puts "In user_is_admin, admin: #{admin.inspect}"
    errors.add(:admin, "must be an admin") unless admin&.admin?
  end
end
