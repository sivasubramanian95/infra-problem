####AKS Cluster#######

resource "azurerm_resource_group" "k8s" {
  name     = var.resourcename
  location = var.location
}
resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.clustername
  location            = azurerm_resource_group.k8s.location
  resource_group_name = azurerm_resource_group.k8s.name
  dns_prefix          = var.dnspreffix
default_node_pool {
    name       = "default"
    node_count = var.agentnode
    vm_size    = var.size
  }
service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

data "azurerm_subscription" "current" {
}

resource "local_file" "kube_config" {
  content    = azurerm_kubernetes_cluster.k8s.kube_config_raw
  filename   = ".kube/config"   
}


resource "null_resource" "set-kube-config" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.k8s.name} -g ${azurerm_resource_group.k8s.name} --file \".kube/${azurerm_kubernetes_cluster.k8s.name}\" --admin --overwrite-existing"
  }
  depends_on = [local_file.kube_config]
}
