# encoding: UTF-8

control "xccdf_org.cisecurity.benchmarks_rule_1.1.1.1_Ensure_mounting_of_cramfs_filesystems_is_disabled" do
  title "Ensure mounting of cramfs filesystems is disabled"
  desc  "
    The cramfs filesystem type is a compressed read-only Linux filesystem embedded in small footprint systems. A cramfs image can be used without having to first decompress the image.
    
    Rationale: Removing support for unneeded filesystem types reduces the local attack surface of the server. If this filesystem type is not needed, disable it.
  "
  impact 1.0
  describe kernel_module('cramfs') do
    it { should_not be_loaded }
    it { should be_disabled }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_1.1.3_Ensure_nodev_option_set_on_tmp_partition" do
  title "Ensure nodev option set on /tmp partition"
  desc  "
    The nodev mount option specifies that the filesystem cannot contain special devices.
    
    Rationale: Since the /tmp filesystem is not intended to support devices, set this option to ensure that users cannot attempt to create block or character special devices in /tmp.
  "
  impact 1.0
  describe mount('/tmp') do
    it { should be_mounted }
    its('options') { should include 'nodev' }
  end
end


control "xccdf_org.cisecurity.benchmarks_rule_1.1.17_Ensure_nodev_option_set_on_removable_media_partitions" do
  title "Ensure nodev option set on removable media partitions"
  desc  "
    The nodev mount option specifies that the filesystem cannot contain special devices.
    
    Rationale: Removable media containing character and block special devices could be used to circumvent security controls by allowing non-root users to access sensitive device files such as /dev/kmem or the raw disk partitions.
  "
  impact 0.0
  describe "No tests defined for this control" do
    skip "No tests defined for this control"
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_1.1.21_Disable_Automounting" do
  title "Disable Automounting"
  desc  "
    autofs allows automatic mounting of devices, typically including CD/DVDs and USB drives.
    
    Rationale: With automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.
  "
  impact 1.0
  describe service('autofs') do
    it { should_not be_running }
    it { should_not be_enabled }
  end
end


control "xccdf_org.cisecurity.benchmarks_rule_1.3.2_Ensure_filesystem_integrity_is_regularly_checked" do
  title "Ensure filesystem integrity is regularly checked"
  desc  "
    Periodic checking of the filesystem integrity is needed to detect changes to the filesystem.
    
    Rationale: Periodic file checking allows the system administrator to determine on a regular basis if critical files have been changed in an unauthorized fashion.
  "
  impact 1.0
  describe.one do
    describe crontab do
      its('commands') { should include '/usr/sbin/aide --check' }
    end
    crontab_path = ['/var/spool/cron/crontabs/root','/etc/crontab','/etc/cron.hourly/', '/etc/cron.daily/', '/etc/cron.weekly/', '/etc/cron.monthly/', '/etc/cron.d/']
    all_cron_files = Hash.new
    crontab_path.map { |path| all_cron_files[path] = command("ls #{path}").stdout.split("\n") }
    all_cron_files.each do |cron_path, cron_files|
      unless cron_files.empty?
        cron_files.each do |cron_file|
          temp = file(cron_path+cron_file)
          describe temp do
            its('content') { should include 'aide --check' }
          end
        end
      end
    end
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_1.4.1_Ensure_permissions_on_bootloader_config_are_configured" do
  title "Ensure permissions on bootloader config are configured"
  desc  "
    The grub configuration file contains information on boot settings and passwords for unlocking boot options. The grub configuration is usually grub.cfg stored in /boot/grub.
    
    Rationale: Setting the permissions to read and write for root only prevents non-root users from seeing the boot parameters or changing them. Non-root users who read the boot parameters may be able to identify weaknesses in security upon boot and be able to exploit them.
  "
  impact 1.0
  describe file("/boot/grub/grub.cfg") do
    it { should exist }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_executable.by "group" }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_readable.by "group" }
  end
  describe file("/boot/grub/grub.cfg") do
    its("gid") { should cmp 0 }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_writable.by "group" }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_executable.by "other" }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_readable.by "other" }
  end
  describe file("/boot/grub/grub.cfg") do
    it { should_not be_writable.by "other" }
  end
  describe file("/boot/grub/grub.cfg") do
    its("uid") { should cmp 0 }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_1.4.2_Ensure_bootloader_password_is_set" do
  title "Ensure bootloader password is set"
  desc  "
    Setting the boot loader password will require that anyone rebooting the system must enter a password before being able to set command line boot parameters
    
    Rationale: Requiring a boot password upon execution of the boot loader will prevent an unauthorized user from entering boot parameters or changing the boot partition. This prevents users from weakening security (e.g. turning off SELinux at boot time).
  "
  impact 1.0
  describe.one do
    describe file("/boot/grub/grub.cfg") do
      its("content") { should match(/^\s*set\s+superusers\s*=\s*"[^"]*"\s*(\s+#.*)?$/) }
    end
    describe file("/boot/grub/grub.cfg") do
      its("content") { should match(/^\s*password_pbkdf2\s+\S+\s+\S+\s*(\s+#.*)?$/) }
    end
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_1.7.1.4_Ensure_permissions_on_etcmotd_are_configured" do
  title "Ensure permissions on /etc/motd are configured"
  desc  "
    The contents of the /etc/motd file are displayed to users after login and function as a message of the day for authenticated users.
    
    Rationale: If the /etc/motd file does not have the correct ownership it could be modified by unauthorized users with incorrect or misleading information.
  "
  impact 1.0
  describe file("/etc/motd") do
    it { should exist }
    it { should_not be_executable.by "group" }
    it { should be_readable.by "group" }
    its("gid") { should cmp 0 }
    it { should_not be_writable.by "group" }
    it { should_not be_executable.by "other" }
    it { should be_readable.by "other" }
    it { should_not be_writable.by "other" }
    it { should_not be_setgid }
    it { should_not be_sticky }
    it { should_not be_setuid }
    it { should_not be_executable.by "owner" }
    it { should be_readable.by "owner" }
    its("uid") { should cmp 0 }
    it { should be_writable.by "owner" }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_6.2.16_Ensure_no_duplicate_UIDs_exist" do
  title "Ensure no duplicate UIDs exist"
  desc  "
    Although the useradd program will not let you create a duplicate User ID (UID), it is possible for an administrator to manually edit the /etc/passwd file and change the UID field.
    
    Rationale: Users must be assigned unique UIDs for accountability and to ensure appropriate access protections.
  "
  impact 1.0
  describe passwd() do
    its('uids') { should_not contain_duplicates }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_6.2.17_Ensure_no_duplicate_GIDs_exist" do
  title "Ensure no duplicate GIDs exist"
  desc  "
    Although the groupadd program will not let you create a duplicate Group ID (GID), it is possible for an administrator to manually edit the /etc/group file and change the GID field.
    
    Rationale: User groups must be assigned unique GIDs for accountability and to ensure appropriate access protections.
  "
  impact 1.0
  describe etc_group() do
    its('gids') { should_not contain_duplicates }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_6.2.18_Ensure_no_duplicate_user_names_exist" do
  title "Ensure no duplicate user names exist"
  desc  "
    Although the useradd program will not let you create a duplicate user name, it is possible for an administrator to manually edit the /etc/passwd file and change the user name.
    
    Rationale: If a user is assigned a duplicate user name, it will create and have access to files with the first UID for that username in /etc/passwd. For example, if \"test4\" has a UID of 1000 and a subsequent \"test4\" entry has a UID of 2000, logging in as \"test4\" will use UID 1000. Effectively, the UID is shared, which is a security problem.
  "
  impact 1.0
  describe passwd() do
    its('users') { should_not contain_duplicates }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_6.2.19_Ensure_no_duplicate_group_names_exist" do
  title "Ensure no duplicate group names exist"
  desc  "
    Although the groupadd program will not let you create a duplicate group name, it is possible for an administrator to manually edit the /etc/group file and change the group name.
    
    Rationale: If a group is assigned a duplicate group name, it will create and have access to files with the first GID for that group in /etc/group. Effectively, the GID is shared, which is a security problem.
  "
  impact 1.0
  describe etc_group() do
    its('groups') { should_not contain_duplicates }
  end
end

control "xccdf_org.cisecurity.benchmarks_rule_6.2.20_Ensure_shadow_group_is_empty" do
  title "Ensure shadow group is empty"
  desc  "
    The shadow group allows system programs which require access the ability to read the /etc/shadow file. No users should be assigned to the shadow group.
    
    Rationale: Any users assigned to the shadow group would be granted read access to the /etc/shadow file. If attackers can gain read access to the /etc/shadow file, they can easily run a password cracking program against the hashed passwords to break them. Other security information that is stored in the /etc/shadow file (such as expiration) could also be useful to subvert additional user accounts.
  "
  impact 1.0
  describe file("/etc/group") do
    its("content") { should_not match(/^shadow:[^:]*:[^:]*:[^:]+$/) }
  end
end