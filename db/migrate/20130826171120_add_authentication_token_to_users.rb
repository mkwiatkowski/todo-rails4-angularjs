class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :authentication_token
    end
  end
end
