set :environment, "development"

every "0 0 1 * *" do
  rake "job:mailmonth"
end
