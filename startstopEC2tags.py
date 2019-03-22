import boto3
import logging

ec2 = boto3.resource('ec2')

def lambda_handler(event, context):

    filters = [{
            'Name': 'tag:Name', 
            'Values': ['Hotshow hotshow4 *'] 
        },
        {
            'Name': 'instance-state-name', 
            'Values': ['stopped']
        }
    ]
    
    instances = ec2.instances.filter(Filters=filters)
    
    stoppedInstances = [instance.id for instance in instances]
    
    
    if len(stoppedInstances) > 0:
        startingUp = ec2.instances.filter(InstanceIds=stoppedInstances).start()	
        
        =====================
        
import boto3
ec2 = boto3.resource('ec2')

def lambda_handler(event, context):
    filters = [{
            'Name': 'tag:Name',
            'Values': ['Hotshow hotshow4 *']
        }
     ]
    
    instances = ec2.instances.filter(Filters=filters)

    runningInstances = [instance.id for instance in instances]
    
    if len(runningInstances) > 0:
        shuttingDown = ec2.instances.filter(InstanceIds=runningInstances).stop()
