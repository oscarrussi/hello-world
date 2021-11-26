class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles
  VALID_ROLES = %w[super_admin content_manager].freeze
  validates :name, inclusion: { in: VALID_ROLES }

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify
end
