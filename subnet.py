#!/usr/local/bin/python3
#coding:utf-8
import yaml
import json
import ipaddress

input_stream = open("sample.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resources_data = {'resources':{} }

subnets_data = {}
subnet = {}


for subnet_data in input_data['networks']:
    subnet[subnet_data['name']+"_subnet"] = {'type': 'OS::Neutron::Subnet','depends_on':'','properties':{'name':'','network_id':{'get_resource':''},'cidr':'','gateway_ip':'','dns_nameservers':[],'allocation_pools':[{'start':'','end':''}]}}
    subnet[subnet_data['name']+"_subnet"]['depends_on'] = subnet_data['name']
    subnet[subnet_data['name']+"_subnet"]['properties']['name'] = subnet_data['name']+"_subnet"
    subnet[subnet_data['name']+"_subnet"]['properties']['network_id']['get_resource'] = subnet_data['name']
    subnet[subnet_data['name']+"_subnet"]['properties']['cidr'] = subnet_data['cidr']
    address = ipaddress.ip_network(subnet_data['cidr'])
    subnet[subnet_data['name']+"_subnet"]['properties']['gateway_ip'] = str(address[1])
    if not subnet_data['dns']:
        subnet[subnet_data['name']+"_subnet"]['properties']['dns_nameservers'].append("8.8.8.8")
    else:
        for dns_data in subnet_data['dns']:
            subnet[subnet_data['name']+"_subnet"]['properties']['dns_nameservers'].append(dns_data)
    subnet[subnet_data['name']+"_subnet"]['properties']['allocation_pools'][0]['start'] = str(address[2])
    subnet[subnet_data['name']+"_subnet"]['properties']['allocation_pools'][0]['end'] = str(address[-2])


data_all = {}
for data in [standard_data,resources_data]:
    data_all.update(data)

data_all['resources'] = subnet

yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
