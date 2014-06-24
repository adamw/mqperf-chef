directory "/mnt/rabbit" do
	owner "root"
	group "root"
	mode 0777
	action :create
end

pull_and_run_app(:rabbit)