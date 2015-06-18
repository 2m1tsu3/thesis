#!/usr/local/bin/python3
#coding:utf-8
import yaml
import json

input_stream = open("input.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resources_data = {'resources':{} }

instances_data = {}
instance = {}

for instance_data in input_data['instances']:
    instance[instance_data['name']] = {'type': 'OS::Nova::Server','properties':{'name':'','networks':[],'flavor': '','image': 'CentOS7_Cloud-init','key_name': ''}}
    instance[instance_data['name']]['properties']['name'] = instance_data['name']
    for ins_net_data in instance_data['networks']:
        instance[instance_data['name']]['properties']['networks'].append(ins_net_data)
    instance[instance_data['name']]['properties']['flavor'] = instance_data['flavor']
    instance[instance_data['name']]['properties']['key_name'] = instance_data['key']

data_all = {}
for data in [standard_data,resources_data]:
    data_all.update(data)

data_all['resources'] = instance

yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
