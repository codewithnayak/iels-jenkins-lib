gcloud iam service-accounts add-iam-policy-binding workload-test-svc@fourth-cirrus-422013.iam.gserviceaccount.com --role roles/iam.workloadIdentityUser --member "serviceAccount:fourth-cirrus-422013.svc.id.goog[jenkins/workload-service-account]"

2nd --
gcloud iam service-accounts add-iam-policy-binding iels-resource-creator@fourth-cirrus-422013.iam.gserviceaccount.com --role roles/iam.workloadIdentityUser --member "serviceAccount:fourth-cirrus-422013.svc.id.goog[jenkins/terraform-service-account]"
