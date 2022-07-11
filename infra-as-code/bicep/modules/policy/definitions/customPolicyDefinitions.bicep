targetScope = 'managementGroup'

@description('The management group scope to which the policy definitions are to be created at. DEFAULT VALUE = "alz"')
param parTargetManagementGroupId string = 'alz'

@description('Set Parameter to true to Opt-out of deployment telemetry')
param parTelemetryOptOut bool = false

var varTargetManagementGroupResourceId = tenantResourceId('Microsoft.Management/managementGroups', parTargetManagementGroupId)

// This variable contains a number of objects that load in the custom Azure Policy Defintions that are provided as part of the ESLZ/ALZ reference implementation - this is automatically created in the file 'infra-as-code\bicep\modules\policy\lib\policy_definitions\_policyDefinitionsBicepInput.txt' via a GitHub action, that runs on a daily schedule, and is then manually copied into this variable. 
var varCustomPolicyDefinitionsArray = [
  {
    name: 'Append-AppService-httpsonly'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_append_appservice_httpsonly.json'))
  }
  {
    name: 'Append-AppService-latestTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_append_appservice_latesttls.json'))
  }
  {
    name: 'Append-KV-SoftDelete'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_append_kv_softdelete.json'))
  }
  {
    name: 'Append-Redis-disableNonSslPort'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_append_redis_disablenonsslport.json'))
  }
  {
    name: 'Append-Redis-sslEnforcement'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_append_redis_sslenforcement.json'))
  }
  {
    name: 'Audit-MachineLearning-PrivateEndpointId'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_audit_machinelearning_privateendpointid.json'))
  }
  {
    name: 'Deny-AA-child-resources'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_aa_child_resources.json'))
  }
  {
    name: 'Deny-AppGW-Without-WAF'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_appgw_without_waf.json'))
  }
  {
    name: 'Deny-AppServiceApiApp-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_appserviceapiapp_http.json'))
  }
  {
    name: 'Deny-AppServiceFunctionApp-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_appservicefunctionapp_http.json'))
  }
  {
    name: 'Deny-AppServiceWebApp-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_appservicewebapp_http.json'))
  }
  {
    name: 'Deny-Databricks-NoPublicIp'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_databricks_nopublicip.json'))
  }
  {
    name: 'Deny-Databricks-Sku'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_databricks_sku.json'))
  }
  {
    name: 'Deny-Databricks-VirtualNetwork'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_databricks_virtualnetwork.json'))
  }
  {
    name: 'Deny-MachineLearning-Aks'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_aks.json'))
  }
  {
    name: 'Deny-MachineLearning-Compute-SubnetId'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_compute_subnetid.json'))
  }
  {
    name: 'Deny-MachineLearning-Compute-VmSize'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_compute_vmsize.json'))
  }
  {
    name: 'Deny-MachineLearning-ComputeCluster-RemoteLoginPortPublicAccess'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_computecluster_remoteloginportpublicaccess.json'))
  }
  {
    name: 'Deny-MachineLearning-ComputeCluster-Scale'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_computecluster_scale.json'))
  }
  {
    name: 'Deny-MachineLearning-HbiWorkspace'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_hbiworkspace.json'))
  }
  {
    name: 'Deny-MachineLearning-PublicAccessWhenBehindVnet'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_publicaccesswhenbehindvnet.json'))
  }
  {
    name: 'Deny-MachineLearning-PublicNetworkAccess'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_machinelearning_publicnetworkaccess.json'))
  }
  {
    name: 'Deny-MySql-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_mysql_http.json'))
  }
  {
    name: 'Deny-PostgreSql-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_postgresql_http.json'))
  }
  {
    name: 'Deny-Private-DNS-Zones'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_private_dns_zones.json'))
  }
  {
    name: 'Deny-PublicEndpoint-MariaDB'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_publicendpoint_mariadb.json'))
  }
  {
    name: 'Deny-PublicIP'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_publicip.json'))
  }
  {
    name: 'Deny-RDP-From-Internet'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_rdp_from_internet.json'))
  }
  {
    name: 'Deny-Redis-http'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_redis_http.json'))
  }
  {
    name: 'Deny-Sql-minTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_sql_mintls.json'))
  }
  {
    name: 'Deny-SqlMi-minTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_sqlmi_mintls.json'))
  }
  {
    name: 'Deny-Storage-minTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_storage_mintls.json'))
  }
  {
    name: 'Deny-Subnet-Without-Nsg'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_subnet_without_nsg.json'))
  }
  {
    name: 'Deny-Subnet-Without-Udr'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_subnet_without_udr.json'))
  }
  {
    name: 'Deny-VNET-Peer-Cross-Sub'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_vnet_peer_cross_sub.json'))
  }
  {
    name: 'Deny-VNET-Peering-To-Non-Approved-VNETs'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_vnet_peering_to_non_approved_vnets.json'))
  }
  {
    name: 'Deny-VNet-Peering'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deny_vnet_peering.json'))
  }
  {
    name: 'Deploy-ASC-SecurityContacts'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_asc_securitycontacts.json'))
  }
  {
    name: 'Deploy-Budget'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_budget.json'))
  }
  {
    name: 'Deploy-Custom-Route-Table'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_custom_route_table.json'))
  }
  {
    name: 'Deploy-DDoSProtection'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_ddosprotection.json'))
  }
  {
    name: 'Deploy-Diagnostics-AA'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_aa.json'))
  }
  {
    name: 'Deploy-Diagnostics-ACI'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_aci.json'))
  }
  {
    name: 'Deploy-Diagnostics-ACR'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_acr.json'))
  }
  {
    name: 'Deploy-Diagnostics-AnalysisService'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_analysisservice.json'))
  }
  {
    name: 'Deploy-Diagnostics-ApiForFHIR'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_apiforfhir.json'))
  }
  {
    name: 'Deploy-Diagnostics-APIMgmt'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_apimgmt.json'))
  }
  {
    name: 'Deploy-Diagnostics-ApplicationGateway'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_applicationgateway.json'))
  }
  {
    name: 'Deploy-Diagnostics-AVDScalingPlans'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_avdscalingplans.json'))
  }
  {
    name: 'Deploy-Diagnostics-Bastion'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_bastion.json'))
  }
  {
    name: 'Deploy-Diagnostics-CDNEndpoints'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_cdnendpoints.json'))
  }
  {
    name: 'Deploy-Diagnostics-CognitiveServices'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_cognitiveservices.json'))
  }
  {
    name: 'Deploy-Diagnostics-CosmosDB'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_cosmosdb.json'))
  }
  {
    name: 'Deploy-Diagnostics-Databricks'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_databricks.json'))
  }
  {
    name: 'Deploy-Diagnostics-DataExplorerCluster'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_dataexplorercluster.json'))
  }
  {
    name: 'Deploy-Diagnostics-DataFactory'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_datafactory.json'))
  }
  {
    name: 'Deploy-Diagnostics-DLAnalytics'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_dlanalytics.json'))
  }
  {
    name: 'Deploy-Diagnostics-EventGridSub'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_eventgridsub.json'))
  }
  {
    name: 'Deploy-Diagnostics-EventGridSystemTopic'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_eventgridsystemtopic.json'))
  }
  {
    name: 'Deploy-Diagnostics-EventGridTopic'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_eventgridtopic.json'))
  }
  {
    name: 'Deploy-Diagnostics-ExpressRoute'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_expressroute.json'))
  }
  {
    name: 'Deploy-Diagnostics-Firewall'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_firewall.json'))
  }
  {
    name: 'Deploy-Diagnostics-FrontDoor'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_frontdoor.json'))
  }
  {
    name: 'Deploy-Diagnostics-Function'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_function.json'))
  }
  {
    name: 'Deploy-Diagnostics-HDInsight'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_hdinsight.json'))
  }
  {
    name: 'Deploy-Diagnostics-iotHub'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_iothub.json'))
  }
  {
    name: 'Deploy-Diagnostics-LoadBalancer'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_loadbalancer.json'))
  }
  {
    name: 'Deploy-Diagnostics-LogicAppsISE'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_logicappsise.json'))
  }
  {
    name: 'Deploy-Diagnostics-MariaDB'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_mariadb.json'))
  }
  {
    name: 'Deploy-Diagnostics-MediaService'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_mediaservice.json'))
  }
  {
    name: 'Deploy-Diagnostics-MlWorkspace'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_mlworkspace.json'))
  }
  {
    name: 'Deploy-Diagnostics-MySQL'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_mysql.json'))
  }
  {
    name: 'Deploy-Diagnostics-NetworkSecurityGroups'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_networksecuritygroups.json'))
  }
  {
    name: 'Deploy-Diagnostics-NIC'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_nic.json'))
  }
  {
    name: 'Deploy-Diagnostics-PostgreSQL'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_postgresql.json'))
  }
  {
    name: 'Deploy-Diagnostics-PowerBIEmbedded'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_powerbiembedded.json'))
  }
  {
    name: 'Deploy-Diagnostics-RedisCache'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_rediscache.json'))
  }
  {
    name: 'Deploy-Diagnostics-Relay'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_relay.json'))
  }
  {
    name: 'Deploy-Diagnostics-SignalR'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_signalr.json'))
  }
  {
    name: 'Deploy-Diagnostics-SQLElasticPools'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_sqlelasticpools.json'))
  }
  {
    name: 'Deploy-Diagnostics-SQLMI'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_sqlmi.json'))
  }
  {
    name: 'Deploy-Diagnostics-TimeSeriesInsights'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_timeseriesinsights.json'))
  }
  {
    name: 'Deploy-Diagnostics-TrafficManager'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_trafficmanager.json'))
  }
  {
    name: 'Deploy-Diagnostics-VirtualNetwork'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_virtualnetwork.json'))
  }
  {
    name: 'Deploy-Diagnostics-VM'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_vm.json'))
  }
  {
    name: 'Deploy-Diagnostics-VMSS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_vmss.json'))
  }
  {
    name: 'Deploy-Diagnostics-VNetGW'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_vnetgw.json'))
  }
  {
    name: 'Deploy-Diagnostics-WebServerFarm'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_webserverfarm.json'))
  }
  {
    name: 'Deploy-Diagnostics-Website'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_website.json'))
  }
  {
    name: 'Deploy-Diagnostics-WVDAppGroup'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_wvdappgroup.json'))
  }
  {
    name: 'Deploy-Diagnostics-WVDHostPools'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_wvdhostpools.json'))
  }
  {
    name: 'Deploy-Diagnostics-WVDWorkspace'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_diagnostics_wvdworkspace.json'))
  }
  {
    name: 'Deploy-FirewallPolicy'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_firewallpolicy.json'))
  }
  {
    name: 'Deploy-MySQL-sslEnforcement'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_mysql_sslenforcement.json'))
  }
  {
    name: 'Deploy-Nsg-FlowLogs-to-LA'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_nsg_flowlogs_to_la.json'))
  }
  {
    name: 'Deploy-Nsg-FlowLogs'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_nsg_flowlogs.json'))
  }
  {
    name: 'Deploy-PostgreSQL-sslEnforcement'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_postgresql_sslenforcement.json'))
  }
  {
    name: 'Deploy-Sql-AuditingSettings'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sql_auditingsettings.json'))
  }
  {
    name: 'Deploy-SQL-minTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sql_mintls.json'))
  }
  {
    name: 'Deploy-Sql-SecurityAlertPolicies'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sql_securityalertpolicies.json'))
  }
  {
    name: 'Deploy-Sql-Tde'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sql_tde.json'))
  }
  {
    name: 'Deploy-Sql-vulnerabilityAssessments'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sql_vulnerabilityassessments.json'))
  }
  {
    name: 'Deploy-SqlMi-minTLS'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_sqlmi_mintls.json'))
  }
  {
    name: 'Deploy-Storage-sslEnforcement'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_storage_sslenforcement.json'))
  }
  {
    name: 'Deploy-VNET-HubSpoke'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_vnet_hubspoke.json'))
  }
  {
    name: 'Deploy-Windows-DomainJoin'
    libDefinition: json(loadTextContent('lib/policy_definitions/policy_definition_es_deploy_windows_domainjoin.json'))
  }
]

// This variable contains a number of objects that load in the custom Azure Policy Set/Initiative Defintions that are provided as part of the ESLZ/ALZ reference implementation - this is automatically created in the file 'infra-as-code\bicep\modules\policy\lib\policy_set_definitions\_policySetDefinitionsBicepInput.txt' via a GitHub action, that runs on a daily schedule, and is then manually copied into this variable.
var varCustomPolicySetDefinitionsArray = [
  {
    name: 'Deny-PublicPaaSEndpoints'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'ACRDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/0fdf0491-d080-4575-b627-ad0e843cba0f'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).ACRDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'AFSDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/21a8cd35-125e-4d13-b82d-2e19b7208bb7'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).AFSDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'AKSDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/040732e8-d947-40b8-95d6-854c95024bf8'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).AKSDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'BatchDenyPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/74c5a0ae-5e48-4738-b093-65e23a060488'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).BatchDenyPublicIP.parameters
      }
      {
        definitionReferenceId: 'CosmosDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/797b37f7-06b8-444c-b1ad-fc62867f335a'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).CosmosDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'KeyVaultDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/55615ac9-af46-4a59-874e-391cc3dfb490'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).KeyVaultDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'MySQLFlexDenyPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/c9299215-ae47-4f50-9c54-8a392f68a052'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).MySQLFlexDenyPublicIP.parameters
      }
      {
        definitionReferenceId: 'PostgreSQLFlexDenyPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/5e1de0e3-42cb-4ebc-a86d-61d0c619ca48'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).PostgreSQLFlexDenyPublicIP.parameters
      }
      {
        definitionReferenceId: 'SqlServerDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/1b8ca024-1d5c-4dec-8995-b1a932b41780'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).SqlServerDenyPaasPublicIP.parameters
      }
      {
        definitionReferenceId: 'StorageDenyPaasPublicIP'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/34c877ad-507e-4c82-993e-3452a6e0ad3c'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deny_publicpaasendpoints.parameters.json')).StorageDenyPaasPublicIP.parameters
      }
    ]
  }
  {
    name: 'Deploy-Diagnostics-LogAnalytics'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'ACIDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACI'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).ACIDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'ACRDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ACR'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).ACRDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AKSDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/6c66c325-74c8-42fd-a286-a74b0e2939d8'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AKSDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AnalysisServiceDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AnalysisService'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AnalysisServiceDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'APIforFHIRDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApiForFHIR'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).APIforFHIRDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'APIMgmtDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-APIMgmt'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).APIMgmtDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'ApplicationGatewayDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ApplicationGateway'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).ApplicationGatewayDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AppServiceDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WebServerFarm'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AppServiceDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AppServiceWebappDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Website'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AppServiceWebappDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AutomationDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AA'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AutomationDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'AVDScalingPlansDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-AVDScalingPlans'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).AVDScalingPlansDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'BastionDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Bastion'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).BastionDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'BatchDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/c84e5349-db6d-4769-805e-e14037dab9b5'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).BatchDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'CDNEndpointsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CDNEndpoints'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).CDNEndpointsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'CognitiveServicesDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CognitiveServices'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).CognitiveServicesDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'CosmosDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-CosmosDB'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).CosmosDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'DatabricksDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Databricks'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).DatabricksDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'DataExplorerClusterDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataExplorerCluster'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).DataExplorerClusterDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'DataFactoryDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DataFactory'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).DataFactoryDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'DataLakeAnalyticsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-DLAnalytics'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).DataLakeAnalyticsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'DataLakeStoreDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/d56a5a7c-72d7-42bc-8ceb-3baf4c0eae03'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).DataLakeStoreDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'EventGridSubDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSub'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).EventGridSubDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'EventGridTopicDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridTopic'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).EventGridTopicDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'EventHubDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f6e93e8-6b31-41b1-83f6-36e449a42579'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).EventHubDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'EventSystemTopicDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-EventGridSystemTopic'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).EventSystemTopicDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'ExpressRouteDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-ExpressRoute'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).ExpressRouteDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'FirewallDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Firewall'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).FirewallDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'FrontDoorDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-FrontDoor'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).FrontDoorDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'FunctionAppDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Function'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).FunctionAppDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'HDInsightDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-HDInsight'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).HDInsightDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'IotHubDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-iotHub'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).IotHubDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'KeyVaultDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).KeyVaultDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'LoadBalancerDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LoadBalancer'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).LoadBalancerDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'LogicAppsISEDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-LogicAppsISE'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).LogicAppsISEDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'LogicAppsWFDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/b889a06c-ec72-4b03-910a-cb169ee18721'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).LogicAppsWFDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'MariaDBDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MariaDB'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).MariaDBDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'MediaServiceDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MediaService'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).MediaServiceDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'MlWorkspaceDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MlWorkspace'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).MlWorkspaceDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'MySQLDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-MySQL'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).MySQLDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'NetworkNICDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NIC'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).NetworkNICDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'NetworkPublicIPNicDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/752154a7-1e0f-45c6-a880-ac75a7e4f648'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).NetworkPublicIPNicDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'NetworkSecurityGroupsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-NetworkSecurityGroups'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).NetworkSecurityGroupsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'PostgreSQLDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PostgreSQL'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).PostgreSQLDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'PowerBIEmbeddedDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-PowerBIEmbedded'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).PowerBIEmbeddedDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'RecoveryVaultDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/c717fb0c-d118-4c43-ab3d-ece30ac81fb3'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).RecoveryVaultDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'RedisCacheDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-RedisCache'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).RedisCacheDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'RelayDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-Relay'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).RelayDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'SearchServicesDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/08ba64b8-738f-4918-9686-730d2ed79c7d'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).SearchServicesDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'ServiceBusDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/04d53d87-841c-4f23-8a5b-21564380b55e'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).ServiceBusDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'SignalRDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SignalR'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).SignalRDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'SQLDatabaseDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/b79fa14e-238a-4c2d-b376-442ce508fc84'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).SQLDatabaseDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'SQLElasticPoolsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLElasticPools'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).SQLElasticPoolsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'SQLMDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-SQLMI'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).SQLMDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'StorageAccountDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/6f8f98a4-f108-47cb-8e98-91a0d85cd474'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).StorageAccountDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'StreamAnalyticsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/237e0f7e-b0e8-4ec4-ad46-8c12cb66d673'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).StreamAnalyticsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'TimeSeriesInsightsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TimeSeriesInsights'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).TimeSeriesInsightsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'TrafficManagerDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-TrafficManager'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).TrafficManagerDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'VirtualMachinesDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VM'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).VirtualMachinesDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'VirtualNetworkDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VirtualNetwork'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).VirtualNetworkDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'VMSSDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VMSS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).VMSSDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'VNetGWDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-VNetGW'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).VNetGWDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'WVDAppGroupDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDAppGroup'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).WVDAppGroupDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'WVDHostPoolsDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDHostPools'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).WVDHostPoolsDeployDiagnosticLogDeployLogAnalytics.parameters
      }
      {
        definitionReferenceId: 'WVDWorkspaceDeployDiagnosticLogDeployLogAnalytics'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Diagnostics-WVDWorkspace'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_diagnostics_loganalytics.parameters.json')).WVDWorkspaceDeployDiagnosticLogDeployLogAnalytics.parameters
      }
    ]
  }
  {
    name: 'Deploy-MDFC-Config'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'ascExport'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/ffb6f416-7bd2-4488-8828-56585fef2be9'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).ascExport.parameters
      }
      {
        definitionReferenceId: 'defenderForAppServices'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForAppServices.parameters
      }
      {
        definitionReferenceId: 'defenderForArm'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/b7021b2b-08fd-4dc0-9de7-3c6ece09faf9'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForArm.parameters
      }
      {
        definitionReferenceId: 'defenderforContainers'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/c9ddb292-b203-4738-aead-18e2716e858f'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderforContainers.parameters
      }
      {
        definitionReferenceId: 'defenderForDns'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/2370a3c1-4a25-4283-a91a-c9c1a145fb2f'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForDns.parameters
      }
      {
        definitionReferenceId: 'defenderForKeyVaults'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f725891-01c0-420a-9059-4fa46cb770b7'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForKeyVaults.parameters
      }
      {
        definitionReferenceId: 'defenderForOssDb'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/44433aa3-7ec2-4002-93ea-65c65ff0310a'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForOssDb.parameters
      }
      {
        definitionReferenceId: 'defenderForSqlPaas'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/b99b73e7-074b-4089-9395-b7236f094491'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForSqlPaas.parameters
      }
      {
        definitionReferenceId: 'defenderForSqlServerVirtualMachines'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/50ea7265-7d8c-429e-9a7d-ca1f410191c3'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForSqlServerVirtualMachines.parameters
      }
      {
        definitionReferenceId: 'defenderForStorageAccounts'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/74c30959-af11-47b3-9ed2-a26e03f427a3'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForStorageAccounts.parameters
      }
      {
        definitionReferenceId: 'defenderForVM'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/8e86a5b6-b9bd-49d1-8e21-4bb8a0862222'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).defenderForVM.parameters
      }
      {
        definitionReferenceId: 'securityEmailContact'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-ASC-SecurityContacts'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_mdfc_config.parameters.json')).securityEmailContact.parameters
      }
    ]
  }
  {
    name: 'Deploy-Sql-Security'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_sql_security.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'SqlDbAuditingSettingsDeploySqlSecurity'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-AuditingSettings'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_sql_security.parameters.json')).SqlDbAuditingSettingsDeploySqlSecurity.parameters
      }
      {
        definitionReferenceId: 'SqlDbSecurityAlertPoliciesDeploySqlSecurity'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-SecurityAlertPolicies'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_sql_security.parameters.json')).SqlDbSecurityAlertPoliciesDeploySqlSecurity.parameters
      }
      {
        definitionReferenceId: 'SqlDbTdeDeploySqlSecurity'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-Tde'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_sql_security.parameters.json')).SqlDbTdeDeploySqlSecurity.parameters
      }
      {
        definitionReferenceId: 'SqlDbVulnerabilityAssessmentsDeploySqlSecurity'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Sql-vulnerabilityAssessments'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_deploy_sql_security.parameters.json')).SqlDbVulnerabilityAssessmentsDeploySqlSecurity.parameters
      }
    ]
  }
  {
    name: 'Enforce-Encryption-CMK'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'ACRCmkDeny'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/5b9159ae-1701-4a6f-9a7a-aa9c8ddd0580'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).ACRCmkDeny.parameters
      }
      {
        definitionReferenceId: 'AksCmkDeny'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/7d7be79c-23ba-4033-84dd-45e2a5ccdd67'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).AksCmkDeny.parameters
      }
      {
        definitionReferenceId: 'AzureBatchCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/99e9ccd8-3db9-4592-b0d1-14b1715a4d8a'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).AzureBatchCMKEffect.parameters
      }
      {
        definitionReferenceId: 'CognitiveServicesCMK'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/67121cc7-ff39-4ab8-b7e3-95b84dab487d'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).CognitiveServicesCMK.parameters
      }
      {
        definitionReferenceId: 'CosmosCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/1f905d99-2ab7-462c-a6b0-f709acca6c8f'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).CosmosCMKEffect.parameters
      }
      {
        definitionReferenceId: 'DataBoxCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/86efb160-8de7-451d-bc08-5d475b0aadae'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).DataBoxCMKEffect.parameters
      }
      {
        definitionReferenceId: 'EncryptedVMDisksEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/0961003e-5a0a-4549-abde-af6a37f2724d'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).EncryptedVMDisksEffect.parameters
      }
      {
        definitionReferenceId: 'HealthcareAPIsCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/051cba44-2429-45b9-9649-46cec11c7119'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).HealthcareAPIsCMKEffect.parameters
      }
      {
        definitionReferenceId: 'MySQLCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/83cef61d-dbd1-4b20-a4fc-5fbc7da10833'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).MySQLCMKEffect.parameters
      }
      {
        definitionReferenceId: 'PostgreSQLCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/18adea5e-f416-4d0f-8aa8-d24321e3e274'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).PostgreSQLCMKEffect.parameters
      }
      {
        definitionReferenceId: 'SqlServerTDECMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/0d134df8-db83-46fb-ad72-fe0c9428c8dd'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).SqlServerTDECMKEffect.parameters
      }
      {
        definitionReferenceId: 'StorageCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/6fac406b-40ca-413b-bf8e-0bf964659c25'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).StorageCMKEffect.parameters
      }
      {
        definitionReferenceId: 'StreamAnalyticsCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/87ba29ef-1ab3-4d82-b763-87fcd4f531f7'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).StreamAnalyticsCMKEffect.parameters
      }
      {
        definitionReferenceId: 'SynapseWorkspaceCMKEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/f7d52b2d-e161-4dfa-a82b-55e564167385'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).SynapseWorkspaceCMKEffect.parameters
      }
      {
        definitionReferenceId: 'WorkspaceCMK'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/ba769a63-b8cc-4b2d-abf6-ac33c7204be8'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encryption_cmk.parameters.json')).WorkspaceCMK.parameters
      }
    ]
  }
  {
    name: 'Enforce-EncryptTransit'
    libSetDefinition: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.json'))
    libSetChildDefinitions: [
      {
        definitionReferenceId: 'AKSIngressHttpsOnlyEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).AKSIngressHttpsOnlyEffect.parameters
      }
      {
        definitionReferenceId: 'APIAppServiceHttpsEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceApiApp-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).APIAppServiceHttpsEffect.parameters
      }
      {
        definitionReferenceId: 'APIAppServiceLatestTlsEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/8cb6aa8b-9e41-4f4e-aa25-089a7ac2581e'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).APIAppServiceLatestTlsEffect.parameters
      }
      {
        definitionReferenceId: 'AppServiceHttpEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-httpsonly'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).AppServiceHttpEffect.parameters
      }
      {
        definitionReferenceId: 'AppServiceminTlsVersion'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Append-AppService-latestTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).AppServiceminTlsVersion.parameters
      }
      {
        definitionReferenceId: 'FunctionLatestTlsEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/f9d614c5-c173-4d56-95a7-b4437057d193'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).FunctionLatestTlsEffect.parameters
      }
      {
        definitionReferenceId: 'FunctionServiceHttpsEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceFunctionApp-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).FunctionServiceHttpsEffect.parameters
      }
      {
        definitionReferenceId: 'MySQLEnableSSLDeployEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-MySQL-sslEnforcement'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).MySQLEnableSSLDeployEffect.parameters
      }
      {
        definitionReferenceId: 'MySQLEnableSSLEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-MySql-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).MySQLEnableSSLEffect.parameters
      }
      {
        definitionReferenceId: 'PostgreSQLEnableSSLDeployEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-PostgreSQL-sslEnforcement'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).PostgreSQLEnableSSLDeployEffect.parameters
      }
      {
        definitionReferenceId: 'PostgreSQLEnableSSLEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-PostgreSql-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).PostgreSQLEnableSSLEffect.parameters
      }
      {
        definitionReferenceId: 'RedisDenyhttps'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-Redis-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).RedisDenyhttps.parameters
      }
      {
        definitionReferenceId: 'RedisdisableNonSslPort'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-disableNonSslPort'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).RedisdisableNonSslPort.parameters
      }
      {
        definitionReferenceId: 'RedisTLSDeployEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Append-Redis-sslEnforcement'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).RedisTLSDeployEffect.parameters
      }
      {
        definitionReferenceId: 'SQLManagedInstanceTLSDeployEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-SqlMi-minTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).SQLManagedInstanceTLSDeployEffect.parameters
      }
      {
        definitionReferenceId: 'SQLManagedInstanceTLSEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-SqlMi-minTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).SQLManagedInstanceTLSEffect.parameters
      }
      {
        definitionReferenceId: 'SQLServerTLSDeployEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-SQL-minTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).SQLServerTLSDeployEffect.parameters
      }
      {
        definitionReferenceId: 'SQLServerTLSEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-Sql-minTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).SQLServerTLSEffect.parameters
      }
      {
        definitionReferenceId: 'StorageDeployHttpsEnabledEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deploy-Storage-sslEnforcement'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).StorageDeployHttpsEnabledEffect.parameters
      }
      {
        definitionReferenceId: 'StorageHttpsEnabledEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-Storage-minTLS'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).StorageHttpsEnabledEffect.parameters
      }
      {
        definitionReferenceId: 'WebAppServiceHttpsEffect'
        definitionId: '${varTargetManagementGroupResourceId}/providers/Microsoft.Authorization/policyDefinitions/Deny-AppServiceWebApp-http'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).WebAppServiceHttpsEffect.parameters
      }
      {
        definitionReferenceId: 'WebAppServiceLatestTlsEffect'
        definitionId: '/providers/Microsoft.Authorization/policyDefinitions/f0e6e85b-9b9f-4a4b-b67b-f730d42f1b0b'
        definitionParameters: json(loadTextContent('lib/policy_set_definitions/policy_set_definition_es_enforce_encrypttransit.parameters.json')).WebAppServiceLatestTlsEffect.parameters
      }
    ]
  }
]

// Customer Usage Attribution Id
var varCuaid = '2b136786-9881-412e-84ba-f4c2822e1ac9'

resource resPolicyDefinitions 'Microsoft.Authorization/policyDefinitions@2020-09-01' = [for policy in varCustomPolicyDefinitionsArray: {
  name: policy.libDefinition.name
  properties: {
    description: policy.libDefinition.properties.description
    displayName: policy.libDefinition.properties.displayName
    metadata: policy.libDefinition.properties.metadata
    mode: policy.libDefinition.properties.mode
    parameters: policy.libDefinition.properties.parameters
    policyType: policy.libDefinition.properties.policyType
    policyRule: policy.libDefinition.properties.policyRule
  }
}]

resource resPolicySetDefinitions 'Microsoft.Authorization/policySetDefinitions@2020-09-01' = [for policySet in varCustomPolicySetDefinitionsArray: {
  dependsOn: [
    resPolicyDefinitions // Must wait for policy definitons to be deployed before starting the creation of Policy Set/Initiative Defininitions
  ]
  name: policySet.libSetDefinition.name
  properties: {
    description: policySet.libSetDefinition.properties.description
    displayName: policySet.libSetDefinition.properties.displayName
    metadata: policySet.libSetDefinition.properties.metadata
    parameters: policySet.libSetDefinition.properties.parameters
    policyType: policySet.libSetDefinition.properties.policyType
    policyDefinitions: [for policySetDef in policySet.libSetChildDefinitions: {
      policyDefinitionReferenceId: policySetDef.definitionReferenceId
      policyDefinitionId: policySetDef.definitionId
      parameters: policySetDef.definitionParameters
    }]
    policyDefinitionGroups: policySet.libSetDefinition.properties.policyDefinitionGroups
  }
}]

// Optional Deployment for Customer Usage Attribution
module modCustomerUsageAttribution '../../../CRML/customerUsageAttribution/cuaIdManagementGroup.bicep' = if (!parTelemetryOptOut) {
  #disable-next-line no-loc-expr-outside-params //Only to ensure telemetry data is stored in same location as deployment. See https://github.com/Azure/ALZ-Bicep/wiki/FAQ#why-are-some-linter-rules-disabled-via-the-disable-next-line-bicep-function for more information
  name: 'pid-${varCuaid}-${uniqueString(deployment().location)}'
  params: {}
}
