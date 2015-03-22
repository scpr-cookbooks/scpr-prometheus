#
# Cookbook Name:: scpr-prometheus
# Recipe:: default
#
# Copyright (c) 2015 Southern California Public Radio

include_recipe "apt"
include_recipe "prometheus::default"

directory node.scpr_prometheus.data_dir do
  action    :create
  recursive true
  owner     node.scpr_prometheus.user
end

# -- Install consul template -- #

include_recipe "consul-template"

# -- Write our config template -- #

template "#{node['prometheus']['flags']['config.file']}.tmplt" do
  action    :create
  source    "prometheus.conf.tmplt.erb"
  notifies  :reload, "service[consul-template]"
end

# Set up our consul template config
consul_template_config "prometheus-config" do
  action :create
  templates([
    {
      source:       "#{node['prometheus']['flags']['config.file']}.tmplt",
      destination:  "#{node['prometheus']['flags']['config.file']}",
      command:      "service prometheus restart",
    }
  ])
  notifies :restart, "service[consul-template]"
end