#!/usr/local/bin/python3
#coding:utf-8
import yaml
import json

input_stream = open("sample.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resources_data = {'resources':{} }

instances_data = {}
port = {}

for instance_data in input_data['instances']:
    for ins_port_data in instance_data['networks']:
        port_name = '%s_%s_port' % (instance_data['name'],ins_port_data['network'])
        subnet_data = {'subnet_id':{'get_resource':''}}
        subnet_data['subnet_id']['get_resource'] = '%s_subnet' % ins_port_data['network']
        port[port_name] = {'type': 'OS::Neutron::Port','depends_on':'','properties':{'name':'','network_id':{'get_resource':''},'security_groups':[],'fixed_ips':[]}}
        port[port_name]['depends_on'] = ins_port_data['network']
        port[port_name]['properties']['name'] = port_name
        port[port_name]['properties']['network_id']['get_resource'] = ins_port_data['network']
        port[port_name]['properties']['security_groups'].append('default')
        port[port_name]['properties']['fixed_ips'].append(subnet_data)


print(port)

data_all = {}
for data in [standard_data,resources_data]:
    data_all.update(data)

data_all['resources'] = port

yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
