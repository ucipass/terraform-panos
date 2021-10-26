terraform {
  required_providers {
     panos = {
      source  = "PaloAltoNetworks/panos"
      version = "~> 1.8.3"
    }
  }
}

provider "panos" {
    hostname = var.PANOS_HOST
    api_key = var.PANOS_API_KEY
    timeout = 10
    verify_certificate = false    
}

variable "PANOS_HOST" {
  type    = string
}

variable "PANOS_API_KEY" {
  type    = string

}

variable "hosts" {
  type    = list(list(string))
  default = [
      ["GOOGLE_DNS1","8.8.8.8"],
      ["GOOGLE_DNS2","8.8.4.4"]
    ]
}

resource "panos_address_group" "GOOGLE_DNS_SERVERS" {
    name = "GOOGLE_DNS_SERVERS"
    description = "GOOGLE_DNS_SERVERS"
    static_addresses = panos_address_object.dns_servers[*].name
}

resource "panos_address_object" "dns_servers" {
    count = length(var.hosts)
    name = var.hosts[count.index][0]
    value = var.hosts[count.index][1]
}

