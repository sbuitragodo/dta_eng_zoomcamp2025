variable "credentials" {
    description = "credentials"
    default = "~/.gc/ny-rides.json"
}

variable "project_name" {
    description = "Project Name"
    default = "ny-taxi-project-448412"
}

variable "region" {
    description = "Project Region"
    default = "us-central1"
}

variable "location" {
    description = "Project Location"
    default = "US"
}

variable "bq_dataset_name" {
    description = "My BigQuery Dataset Name"
    default = "demo_dataset"
}

variable "gcs_bucket_name" {
    description = "My Storage Bucket Name"
    default = "ny-taxi-project-448412-terra-bucket"
}

variable "gcs_storage_class" {
    description = "Bucket Storage Class"
    default = "STANDARD"
}