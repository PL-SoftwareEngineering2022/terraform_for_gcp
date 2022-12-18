// Redis instance
variable "redis_instance_name"{}
variable "redis_tier"{}
variable "region"{}
variable "redis_memory_size_gb"{}
variable "redis_location_id"{}
variable "redis_version"{}
variable "redis_display_name"{}
variable "vpc_name"{}
variable "vpc_self_link"{}

// SQL instance
variable "sql_db_name"{}
variable "sql_db_version"{}
variable "sql_tier"{}
variable "sql_deletion_protection"{}

// GCS Bucket
variable "gcs_bucket_name"{}
variable "gcs_location"{}
variable "force_destroy"{}
variable "uniform_bucket_level_access"{}
variable "versioning_enabled"{}