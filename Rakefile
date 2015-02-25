require 'yaml'

desc 'Boot and ssh into Pi'
task :boot => :config do
  exec <<-SHELL
    echo 'Booting Raspberry Pi in QEMU'
    qemu-system-arm -kernel kernel-qemu \
      -cpu arm1176 \
      -m 256 \
      -M versatilepb \
      -net user,hostfwd=tcp::#{@config['ssh_port']}-:22 \
      -net nic \
      -no-reboot \
      -pidfile #{@config['pid_file']}\
      -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
      -hda #{@config['img_file']} &
    sleep 2
    until ssh pi@localhost -p#{@config['ssh_port']} 2> /dev/null
    do
      for i in `seq 1 5`;
      do
        printf '.'
        sleep 1
      done    
    done
    echo
  SHELL
end

desc 'Kill the running Pi'
task :kill => :config do
  exec "kill -15 `cat #{@config['pid_file']}`"
end

desc 'Print the current config'
task :config do
  @config = YAML.load_file('./config.yml')
end

