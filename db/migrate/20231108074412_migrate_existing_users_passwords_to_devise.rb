class MigrateExistingUsersPasswordsToDevise < ActiveRecord::Migration[7.0]
  def up
    User.find_each do |user|
      new_password = SecureRandom.hex(8)
      user.password = new_password
      user.save
    end
  end
end
