require 'yaml'

desc 'Install QEMU and download a base image'
task :install => [:install_qemu, :download_base_box]

desc 'Install QEMU'
task :install_qemu do
  `which qemu-system-arm`
  if $?.to_i != 0
    system <<-SHELL 
      brew install pkg-config libtool 
      brew unlink qemu 
      brew uninstall qemu 
      brew install https://raw.github.com/Homebrew/homebrew-dupes/master/apple-gcc42.rb
      brew install qemu --env=std --cc=gcc-4.2
    SHELL
  end
end

desc 'Download base box'
task :download_base_box => :config do
  `which wget`
  if $?.to_i != 0
    system 'brew install wget'
  end

  `which unzip`
  if $?.to_i != 0
    system 'brew install unzip'
  end

  Dir.mkdir './images' and puts 'Creating images directory' unless Dir.exist? './images'
  Dir.chdir './images'
  existing_archives = Dir.glob '*.zip'
  existing_images = Dir.glob '*.img'

  puts 'Downloading base box'
  system 'wget --content-disposition http://downloads.raspberrypi.org/raspbian_latest'

  new_archives = Dir.glob('*.zip') - existing_archives
  new_archives.each do |archive|
    system "unzip -n #{archive}"
    system "rm -f #{archive}"
  end

  new_images = Dir.glob '*.img'
  new_image = (new_images - existing_images).first

  Dir.chdir '..'
  unless @config['img_file']
    @config['img_file'] = "./images/#{new_image}"
    File.open('./config.yml', 'w') { |f| YAML.dump(@config, f) }
  end
end

desc 'Boot and ssh into Pi'
task :boot => :config do
  system <<-SHELL
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
        printf '.' sleep 1
      done
    done
    echo
  SHELL
end

desc 'Kill the running Pi'
task :kill => :config do
  system "kill -15 `cat #{@config['pid_file']}`"
end

desc 'Print the current config'
task :config do
  unless File.exists? './config.yml'
    `cp ./config.yml.example ./config.yml`
  end
  @config = YAML.load_file('./config.yml')
end

