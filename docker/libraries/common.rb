def pull_image(name, image)
	script "pull_app_#{name}_image" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
      		docker pull #{image}
    	EOH
  	end
end

def run(name, image, params)
	script "run_app_#{name}_container" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
    		docker run -d --name=#{name} #{image} #{params.join(" ")}
    	EOH
  	end
end

def pull_and_run_app(name)
	data = node[name]
	image = data[:image]
	pull_image(name, image)
	run(name, image, data[:cmdline])
end
