def pull_image(name, image)
	script "pull_app_#{name}_image" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
      		docker pull #{image}
    	EOH
  	end
end

def run(name, image, cmdline, env, docker)
  envs = env.map { |k, v|
    "-e #{k}=#{v}"
  }.join(" ") if env

  docker_cmd = "docker run -d --name=#{name} #{docker} #{envs} #{image} #{cmdline.join(" ") if cmdline}"
  log "Docker command: #{docker_cmd}"

	script "run_app_#{name}_container" do
    	interpreter "bash"
    	user "root"
    	code <<-EOH
    		#{docker_cmd}
    	EOH
  	end
end

def pull_and_run_app(name)
	data = node[name]
	image = data[:image]
	pull_image(name, image)
	run(name, image, data[:cmdline], data[:env], data[:docker])
end
