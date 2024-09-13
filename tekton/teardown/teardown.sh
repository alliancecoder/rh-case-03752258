# ########################### REPRODUCER TEAR DOWN #######################################

# SWITCH TO PROJECT
oc project case03752258

# REMOVE ALL CICD RUNS (prompts y/n)
tkn pipelinerun delete --all
tkn taskrun delete --all

oc delete pvc maven-local-repo-pvc
oc delete pvc pipeline-task-cache-pvc
oc delete rolebinding case03752258-pipeline-sa-scc-rolebinding
oc delete clusterrolebinding case03752258-pipelines-as-code-cleanup-job
# oc delete clusterrole pipelines-as-code-cleanup-job
oc delete sa case03752258-pipeline-sa
oc delete project case03752258