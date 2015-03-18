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

# Register all node exporters
prometheus_job "node-exporter" do
  sd_name "prometheus-node-exporter.service.consul"
end

# Register haproxy exporters
prometheus_job "haproxy-exporter" do
  sd_name "prometheus-haproxy-exporter.service.consul"
end

# Register consul exporter
prometheus_job "consul-exporter" do
  sd_name "prometheus-consul-exporter.service.consul"
end