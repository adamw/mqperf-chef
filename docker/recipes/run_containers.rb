# Run each app.
node[:my_apps].each do |name, image|  
  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d --name=#{name} #{image}
    EOH
  end
end