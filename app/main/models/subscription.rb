class Subscription < Volt::Model
  permissions(:update, :delete, :read) do
    # Can be created, and thats it
    deny
  end
end
