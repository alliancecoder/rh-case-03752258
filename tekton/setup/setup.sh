# ########################### REPRODUCER SET UP #######################################

# PREREQUISITES
# - CREATE THE git-task IS (see /README.md)
# - VERIFY Namespace case03752258 is ACCEPTABLE
# - have openshift-pipelines installed
# - Be logged into your OC Cluster

# CREATE NAMESMAPCE
oc new-project case03752258 --display-name="CASE 03752258" --description="This namesapce is the reproducer for rh case 03752258."

# SWITCH TO PROJECT
oc project case03752258

# INSTALL SERVICE ACCOUNT AND CLUSTER BINDINGS
oc create --save-config=true -f ./serviceAccounts/case03752258-cluster-role-binding.yaml

# ALLOW SERVICE ACCOUNT PRIVILEGED ACCESS WITHIN NAMESPACE (required for tekton tasks requiring priviledged containers)
oc adm policy add-scc-to-user privileged -z case03752258-pipeline-sa -n case03752258

# CREATE MAVEN SETTINGS CONFIG MAP
oc create configmap maven-settings --from-file=./settings.xml  --namespace=case03752258

# CREATE PVC RESOURCES
oc create --save-config=true -f ./pvc/maven-local-repo-pvc.yaml
oc create --save-config=true -f ./pvc/task-pvc.yaml

# CREATE TEKTON TASKS
oc create --save-config=true -f ./tasks/get-source-with-git-task.yaml
oc create --save-config=true -f ./tasks/execute-maven-task.yaml

# CREATE THE PIPELINE
oc create --save-config=true -f ./pipeline/test-and-build-pipeline.yaml