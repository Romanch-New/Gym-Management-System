class Role < ApplicationRecord
  PREDEFINED_ROLES = %w[admin new_user member staff coach nutritionist guest].freeze
  has_and_belongs_to_many :users,
                          join_table: "users_roles",  dependent: :destroy
  
  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true


  validates_each :name do |record, attr, value|
    unless PREDEFINED_ROLES.include?(value)
      record.errors.add(attr, 'is not a predefined role')
    end
  end

  after_initialize :set_default_role, if: :new_record?

  scopify

  private

  def set_default_role
    self.name ||= 'guest'
  end
end
