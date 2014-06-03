def pull_image(name, image)
	script "pull_app_#{name}_image" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
      		docker pull #{image}
    	EOH
  	end
end

def run(name, image, cmdline, env)
  envs = env.map { |k, v|
    "-e #{k}=#{v}"
  }.join(" ")

  log "Docker environment: #{envs}"

	script "run_app_#{name}_container" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
    		docker run -d --name=#{name} #{envs} #{image} #{cmdline.join(" ")}
    	EOH
  	end
end

def pull_and_run_app(name)
	data = node[name]
	image = data[:image]
	pull_image(name, image)
	run(name, image, data[:cmdline], data[:env])
end
