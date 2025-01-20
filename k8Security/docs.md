gcloud iam service-accounts add-iam-policy-binding workload-test-svc@fourth-cirrus-422013.iam.gserviceaccount.com --role roles/iam.workloadIdentityUser --member "serviceAccount:fourth-cirrus-422013.svc.id.goog[jenkins/workload-service-account]"

2nd --
gcloud iam service-accounts add-iam-policy-binding iels-resource-creator@fourth-cirrus-422013.iam.gserviceaccount.com --role roles/iam.workloadIdentityUser --member "serviceAccount:fourth-cirrus-422013.svc.id.goog[jenkins/terraform-service-account]"


keen-ally-438611-t7.svc.id.goog


gcloud iam service-accounts add-iam-policy-binding terraform-default-svc-account@keen-ally-438611-t7.iam.gserviceaccount.com --role roles/iam.workloadIdentityUser --member "serviceAccount:keen-ally-438611-t7.svc.id.goog[jenkins/terraform-default-svc-account]"



