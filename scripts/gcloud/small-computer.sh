gcloud compute \
  --project "$1" \
  disks create "small-computer-1" \
  --size "32" \
  --zone "us-central1-a" \
  --source-snapshot "post-install" \
  --type "pd-ssd"

gcloud beta compute \
  --project "$1" \
  instances create small-computer-1 \
  --zone=us-central1-a \
  --machine-type=e2-medium \
  --subnet=default \
  --network-tier=PREMIUM \
  --no-restart-on-failure \
  --maintenance-policy=TERMINATE \
  --preemptible \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
  --tags=http-server,https-server \
  --disk=name=small-computer-1,device-name=small-computer-1,mode=rw,boot=yes,auto-delete=yes \
  --reservation-affinity=any
