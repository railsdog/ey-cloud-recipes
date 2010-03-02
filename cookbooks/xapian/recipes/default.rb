#
# Cookbook Name:: xapian
# Recipe:: default
#
# Based on a posting in EY support (https://cloud-support.engineyard.com/discussions/problems/865-xapian-bindings)
#
           
case node[:instance_role] when "app_master"
  bash "install-xapian " do
    user "root"
    code 'echo "dev-libs/xapian ~x86" >> /etc/portage/package.keywords/ec2'
  end
  bash "append-portage" do
    user "root"
    code 'echo "dev-libs/xapian-bindings ~x86" >> /etc/portage/package.keywords/ec2'
  end
  execute "emerge-xapian" do
    command 'emerge --sync'
    command 'emerge dev-libs/xapian-bindings'
  end
end