#!/usr/local/bin/python3
#coding:utf-8
import yaml
import json

input_stream = open("input.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resources_data = {'resources':{} }

networks_data = {}
network = {}

for network_data in input_data['networks']:
    network[network_data['name']] = {'type': 'OS::Neutron::Net','properties':{'name':''}}
    network[network_data['name']]['properties']['name'] = network_data['name']

data_all = {}
for data in [standard_data,resources_data]:
    data_all.update(data)

data_all['resources'] = network

yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
