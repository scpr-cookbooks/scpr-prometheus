default['scpr_prometheus']['data_dir']                = "/data/prometheus"
default['scpr_prometheus']['user']                    = "prometheus"

include_attribute "prometheus"

default['prometheus']['init_style']                   = "sysv"
default['prometheus']['flags']['storage.local.path']  = node.scpr_prometheus.data_dir
default['prometheus']['source']['user']               = node.scpr_prometheus.user