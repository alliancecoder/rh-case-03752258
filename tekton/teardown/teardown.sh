# ########################### REPRODUCER TEAR DOWN #######################################

oc delete rolebinding case03752258-pipeline-sa-scc-rolebinding
oc delete clusterrolebinding case03752258-pipelines-as-code-cleanup-job
oc delete clusterrole pipelines-as-code-cleanup-job
oc delete sa case03752258-pipeline-sa
oc delete project case03752258