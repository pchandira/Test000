#1 Resource to create LOG GROUP
# Name: myLoggroup and Description:

resource oci_logging_log_group export_myLoggroup {
  compartment_id = var.compartment_ocid
  defined_tags = { }
  description  = var.log_group_description  # "test log group"
  display_name = var.log_group_display_name # "myLoggroup"
  freeform_tags = { }
}


#2 Resource to create LOGS
# Name: myLog; Type: SERVICE; 
# Details: Service: VCN subnets category : flow logs - all records
# RETENTION: 30 days / 1 month
# category    = "all" / "read" / "write"

resource oci_logging_log export_myLog {
  configuration {
    compartment_id = var.compartment_ocid
    source {
      category    = var.log_category # "all"
      resource    = var.log_subnet_ocid # id
      service     = var.log_service # "flowlogs"
      source_type = var.log_source_type #"OCISERVICE"
    }
  }

  defined_tags = {  }
  display_name = var.log_display_name #"myLog"
  freeform_tags = {  }
  is_enabled         = var.log_is_enabled #"true"
  # Configure source connection > Log Group > Logs
  log_group_id       = oci_logging_log_group.export_myLoggroup.id
  log_type           = var.log_log_type #"SERVICE"
  retention_duration = var.log_retention_duration #"30"
}


#3 Resoure to Create Bucket at Object Storage
# Name : mybucket
# Storage Tier: Standard
# Visibility : Private


resource oci_objectstorage_bucket export_mybucket {
  access_type    = var.bucket_access_type #"NoPublicAccess" # Visibility : Private
  auto_tiering   = var.bucket_auto_tiering #"Disabled"
  compartment_id = var.compartment_ocid
  defined_tags = {  }
  freeform_tags = {  }
  #kms_key_id = <<Optional value not found in discovery>>
  metadata = {  }
  name                  = var.bucket_name # "mybucket"
  namespace             = data.oci_objectstorage_namespace.export_namespace.namespace
  object_events_enabled = var.bucket_object_events_enabled #"false"
  storage_tier          = var.bucket_storage_tier #"Standard"
  versioning            = var.bucket_versioning #"Disabled"
}



#4 Resource to create SERVICE CONNECTORS
# Name : my_serviceconn and DESC
# SOURCE: kind = logging
# TARGET: kind = "objectStorage"  / mybucket/ 420000 /  100     


resource oci_sch_service_connector export_my_serviceconn {
  compartment_id = var.compartment_ocid
  defined_tags = { }
  display_name = var.ser_conn_display_name # "my_serviceconn"
  description  = var.ser_conn_description # "my service connector"
  freeform_tags = { }
  source {
    #cursor = <<Optional value not found in discovery>>
    kind = var.ser_conn_src_kind #"logging"

     log_sources {
       compartment_id = var.compartment_ocid
       log_group_id   = oci_logging_log_group.export_myLoggroup.id # oci_logging_log_group export_myLoggroup
       log_id         = oci_logging_log.export_myLog.id
     }

    #monitoring_sources = <<Optional value not found in discovery>>
    #stream_id = <<Optional value not found in discovery>>
  } 

  #state = "ACTIVE"
  target {
    batch_rollover_size_in_mbs = var.ser_conn_tar_batch_size #"100"
    batch_rollover_time_in_ms  = var.ser_conn_tar_batch_time #"420000"

    # Configure Target Connection Bucket (which is created already)
    bucket                     = var.bucket_name # "mybucket" 
    #namespace = data.oci_objectstorage_namespace.export_namespace.namespace
    kind = var.ser_conn_tar_kind #"objectStorage"
    log_group_id = oci_logging_log_group.export_myLoggroup.id
    compartment_id = var.compartment_ocid

    #dimensions = <<Optional value not found in discovery>>
    #enable_formatted_messaging = <<Optional value not found in discovery>>
    #function_id = <<Optional value not found in discovery>>
    #log_source_identifier = <<Optional value not found in discovery>>
    #metric = <<Optional value not found in discovery>>
    #metric_namespace = <<Optional value not found in discovery>>
    #object_name_prefix = <<Optional value not found in discovery>>
    #stream_id = <<Optional value not found in discovery>>
    #topic_id = <<Optional value not found in discovery>>
  }
}


#5 Resource to create Service Connector Policies
# Allow any-user to manage objects in compartment id ocid1.compartment.oc1..qqq where all {request.principal.type='serviceconnector', target.bucket.name='mybucket', request.principal.compartment.id='ocid1.compartment.oc1..qqq'}

resource "oci_identity_policy" "policy" {
    compartment_id = var.security_compartment_ocid
    description = var.id_policy_description #"Logging to Object Storge Service Connector Policy"
    name = join("", ["ConnectorPolicy-", var.ser_conn_display_name])
    statements = tolist([join("", ["Allow any-user to manage objects in compartment id ", var.security_compartment_ocid, " where all {request.principal.type='serviceconnector', target.bucket.name='", var.bucket_name, "', request.principal.compartment.id='", var.security_compartment_ocid, "'}"])])
}

