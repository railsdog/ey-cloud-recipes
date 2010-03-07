#
# Cookbook Name:: xapian
# Recipe:: default
#
# Based on a posting in EY support (https://cloud-support.engineyard.com/discussions/problems/865-xapian-bindings)
#
           
case node[:instance_role]
  when "solo", "app", "app_master"
    ey_cloud_report "xapian" do
      message "installing xapian bindings"
    end

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
    
    node[:applications].each do |app_name,data|
      user = node[:users].first       
      directory "/data/#{app_name}/shared/db" do
        mode 0755
        owner user[:username]
        group user[:username]
      end
      directory "/data/#{app_name}/shared/db/xapiandb" do
        mode 0755
        owner user[:username]
        group user[:username]
      end
    end
end