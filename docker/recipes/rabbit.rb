directory "/mnt/rabbit" do
	owner "root"
	group "root"
	mode 0777
	action :create
end

apt_package "rabbitmq-server" do
	action :install
end
