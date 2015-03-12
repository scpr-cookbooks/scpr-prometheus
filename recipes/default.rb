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