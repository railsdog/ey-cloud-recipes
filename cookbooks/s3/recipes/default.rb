#
# Cookbook Name:: s3
# Recipe:: default
#
    
node[:applications].each do |app_name,data|
  user = node[:users].first

  case node[:instance_role]
    when "solo", "app", "app_master"   
    
      ey_cloud_report "s3" do
        message "configuring s3 settings"
      end
    
      remote_file "/data/#{app_name}/shared/config/s3.yml" do
        source "s3.yml"
        owner user[:username]
        group user[:username]
        mode 0744
        backup false
      end     
  end
end
