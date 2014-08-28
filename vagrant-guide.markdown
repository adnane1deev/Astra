# Getting Started with Vagrant

### Installing VirtualBox
VirtualBox https://www.virtualbox.org/

### Installing Vagrant
Vagrant http://downloads.vagrantup.com

# Managing Vagrant Boxes and Projects

### Importing and using base boxes
http://www.vagrantbox.es/
https://vagrantcloud.com/discover/featured
```
vagrant init <base-box-name> <url>
vagrant init precise64 http://files.vagrantup.com/precise64.box
```

### Creating projects without importing a base box
```
vagrant init <base-box-name>
vagrant init precise64
```

### Managing Vagrant boxes
```
vagrant box --help
```

The available box-related subcommands are:
```
vagrant box add <name> <url> [--provider provider] [--force]
vagrant box list
vagrant box remove <name> <provider>
vagrant box repackage <name> <provider>
```

### Adding Vagrant boxes
The following command would add a new precise64 box, and if an existing one is found, it will override it:
```
vagrant box add precise64 http://files.vagrantup.com/precise64.box ––force
```

### Listing Vagrant boxes
The list subcommand will list the boxes installed within Vagrant along with the provider that backs the box:
```
vagrant box list
```

### Removing Vagrant boxes
We can remove the box with the remove subcommand. We need to provide the name of the box and the provider that backs it. For example:
```
vagrant box remove lucid32 virtualbox
```

### Repackaging Vagrant boxes
The repackage subcommand lets us convert a Vagrant environment, complete with
any customizations we have made to it, such as software we have installed on it,
into a box which we can reuse and distribute to others.

### Finding Vagrant boxes
1. Lucid32 is available at http://files.vagrantup.com/lucid32.box
2. Lucid64 is available at http://files.vagrantup.com/lucid64.box
3. Precise32 is available at http://files.vagrantup.com/precise32.box
4. Precise64 is available at http://files.vagrantup.com/precise64.box

### Controlling guest machines
#### Powering up the virtual machine
We can power up the virtual machine using the vagrant up command.
```
vagrant up
```

#### Suspending the virtual machine
We can save the current state of the virtual machine to disk so that we can resume it later.
```
vagrant suspend
```

### Resuming the virtual machine
In order to resume a previously suspended virtual machine, we simply run
```
vagrant resume
```

#### Shutting down the virtual machine
```
vagrant halt
```

#### Starting from scratch
```
vagrant destroy
vagrant up
```

#### Connecting to the virtual machine over SSH
```
vagrant ssh
```

### Integration between the host and the guest
#### Port forwarding
Port forwarding is done via lines in the Vagrantfile file, we simply provide the
guest and host ports we wish to map:
```
config.vm.network :forwarded_port, guest: 80, host: 8888
```
If we have other Vagrant-managed virtual machines on our computer, which we
wish to run simultaneously, we can enable auto_correct on specific ports; this way,
if a conflict is found (for example, two VMs trying to map to the same port), one will
try a different port instead:
```
config.vm.network :forwarded_port, guest: 80, host: 8888, auto_correct: true
```

#### Synced folders
Synced folders allow us to share a folder between the host and the guest. By default,
Vagrant shares the folder containing the Vagrant project as /vagrant on the VM. We
can use the following in our Vagrantfile to sync more folders if we wish:
```
config.vm.synced_folder "/Users/michael/assets/" "/var/www/assets"
```
The first parameter is the path to the folder on our machine, the second being the
mount point on the VM. If we use a relative path on our machine, it would be
relative to the project folder.

The Network File System can give us better performance with synced folders than
the default settings, this won't work on Windows hosts, and on Linux/OS X hosts
will require root privileges.
```
config.vm.synced_folder "/Users/michael/assets/" "/var/www/assets", :nfs => true
```

#### Networking
If we want to allow our colleagues
to access our Vagrant-managed VMs directly, we can attach the VM to our internal
network, and VirtualBox will bridge the network between our machine and the VM
and the internal network between our machine and the rest of the machines in your
home or office:
```
config.vm.network :private_network, ip: "192.168.1.100"
```

#### Auto-running commands
SSH provisioning involves running a series of commands on the virtual machine
over SSH when the VM is first setup.

There are two ways we can use SSH provisioning. We can either directly run a
command from our Vagrantfile file with the following line:
```
config.vm.provision :shell, :inline => "sudo apt-get update"
```

Alternatively, we can tell Vagrant to run a particular shell script (the location of the
script specified is relative to our project root, that is, /vagrant):
```
config.vm.provision :shell, :path => "provision.sh"
```

After creating our provisioning [inline-command(s)/bash-scripts(s)]:
if the VM is running, provisioning is done as the following:
```
vagrant provision
```

else if the VM is still OFF, provisioning is done by passing [--provision] to vagrant up subcommand
```
vagrant up --provision
```
