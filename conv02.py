#coding:utf-8
import yaml
import json

input_stream = open("input.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resources_data = {'resources':{} }

instances_data = {}
instance = []

for ins_num,instance_data in enumerate(input_data['instances']):
    instance.append({'type': 'OS::Nova::Server','properties':{'name':'','networks':[],'flavor': '','image': 'CentOS7_Cloud-init','key_name': ''}})
    instance[ins_num]['properties']['name'] = instance_data['name']
    for ins_net_data in instance_data['networks']:
        instance[ins_num]['properties']['networks'].append(ins_net_data)
    instance[ins_num]['properties']['flavor'] = instance_data['flavor']
    instance[ins_num]['properties']['key_name'] = instance_data['key']

for ins in instance:
    instances_data[ins['properties']['name']] = ins

data_all = {}
for data in [standard_data,resources_data]:
    data_all.update(data)

data_all['resources'] = instances_data

yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
