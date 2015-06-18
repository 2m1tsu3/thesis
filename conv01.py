#coding:utf-8
import yaml
import json

input_stream = open("input.json","r")
output_stream = open("output.yml","w")
input_data = json.load(input_stream)

def getVarNames(obj):
    return  [k for k, v in globals().items() if id(obj) == id(v)]

standard_data = {'heat_template_version':'2013-05-23','description':'This HOT is produced by Convert-System'}

resource_data = {'resources':{} }

instance_data = {}
instance1 = {'type': 'OS::Nova::Server','properties':{'name':'ins01','flavor': 'm1.small','image': 'CentOS7_Cloud-init','key_name': 'my_key'}}
instance2 = {'type': 'OS::Nova::Server','properties':{'name':'ins02','flavor': 'm1.small','image': 'CentOS7_Cloud-init','key_name': 'my_key'}}

for ins in [instance1,instance2]:
    instance_data[ins['properties']['name']] = ins

data_all = {}
for data in [standard_data,resource_data]:
    data_all.update(data)

data_all['resources'] = instance_data


yaml.safe_dump(data_all,output_stream,default_flow_style=False)
input_stream.close()
output_stream.close()
