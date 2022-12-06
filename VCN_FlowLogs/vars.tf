variable region { 
    type        = string
    description = "Enter the region"
    default = "us-ashburn-1" 
}

variable compartment_ocid { 
    type        = string
    description = "Enter the compartment_ocid for VCN flowlog"
    #default     = "ocid1.compartment.oc1..aaaaaaaammbn2jdbg5mtzeattgxxv3nnak7r7kb3c4fgcrv76ssgqhbity3a"
}



###1 LOG GROUP -Variables

variable "log_group_description"{
    type        = string
    default = "test log group"
}

variable "log_group_display_name" {
    type        = string
    default = "myLoggroup"
}

###2 LOGS -Variables

variable log_category {
    type        = string  
    description = "LOG: All records / READ / WRITE"
    default = "all"
} 

variable "log_subnet_ocid" {
    type        = string
    description = "Enter subnet_ocid for VCN flowlog"
    #default = "ocid1.subnet.oc1.iad.aaaaaaaaeelmj4qn6gjuzebkw5i56xvvgywliqxkmup6qpfoy3pqrd3jwlja"
}

variable "log_display_name" {
    type        = string  
    default  = "myLog"
}
variable "log_service" {
    type        = string  
    description = "Enable VCN flowlogs -all records (Servicelogs)"
    default = "flowlogs"
}
variable "log_source_type" {
    type        = string  
    default = "OCISERVICE"
}
variable "log_log_type" {
    type        = string
    default = "SERVICE"
} 

variable "log_is_enabled" {
    type        = string  
    description = "Enable Log - (all VCN flowlogs in subnet)"
    default = "true"
} 

variable "log_retention_duration" {
    type        = string
    description = "Retention Period (default: 30 days)"
    default = "30"
}



###3 Object Storage Bucket -Variables

variable "bucket_name" {
    type    = string
    description = "Enter the Object Storage Bucket Name"
    default = "mybucket"
}

variable "bucket_access_type" {
    type        = string  
    description ="Enter Visibility : Private/Public"
    default ="NoPublicAccess" 
}

variable "bucket_storage_tier" {
    type        = string  
    description = "Select the Default Storage Tier(Standard/Archive)"
    default = "Standard"
}

variable "bucket_auto_tiering" {
    type        = string  
    description = "Enable/Disable Auto-Tiering"
    default = "Disabled"
}

variable "bucket_versioning" {
    type        = string  
    description = "Enable/Disable Object Versioning"
    default =  "Disabled"
}

variable "bucket_object_events_enabled" {
    type        = string  
    description = "Enable/Disable Object Events"
    default = "false"
}




###4 SERVICE CONNECTOR -Variables


variable "ser_conn_display_name" {
    type        = string
    description = "Enter Service Connector name "
    default     = "my_serviceconn"
}
variable "ser_conn_description" {
    type        = string  
    default = "service connector description"
} 

variable "ser_conn_src_kind" {
    type        = string  
    description ="Source: Service Connector"
    default ="logging"
}

variable "ser_conn_tar_kind" {
    type        = string  
    description ="Target: Service Connector"
    default ="objectStorage"
}

#1 if SRC=logging ,,,,TAR=function/logging analytics/monitoring/notifications/object storage / streaming
#2 if SRC=streaming ,,,,TAR=function/logging analytics/notifications/object storage / streaming
#3 if SRC=monitoring ,,,,TAR=function/object storage / streaming


variable "ser_conn_tar_batch_size" {
    type        = string  
    description = "Service Connectors: Enter Batch Size (in MBs) "
    default ="100"
}

variable  "ser_conn_tar_batch_time" {
    type        = string  
    description = "Service Connectors: Enter Batch Time (in ms) "
    default = "420000"
}



###5 Service Connector Policies -Variable

variable "security_compartment_ocid" {
    type        = string
    description = "Enter the compartment_ocid for Policy"
    #default = "ocid1.compartment.oc1..aaaaaaaammbn2jdbg5mtzeattgxxv3nnak7r7kb3c4fgcrv76ssgqhbity3a"
}

variable "id_policy_description" {
    type        = string
    default = "Logging to Object Storge Service Connector Policy"
}