
# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Variable file for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Licensed under the Universal Permissive License v 1.0 as 
#              shown at http://oss.oracle.com/licenses/upl.
# ---------------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# ---------------------------------------------------------------------------

# - Input Variables ---------------------------------------------------------
# provider identity parameters
variable "region" {
    # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
    description = "The OCI region where resources will be created"
    type        = string
}

# general oci parameters
variable "compartment_id" {
    description = "OCID of the tcompartment where to create all resources"
    type        = string
}

variable "label_prefix" {
    description = "A string that will be prepended to all resources"
    type        = string
    default     = "none"
}

# vcn parameters
variable "internet_gateway_enabled" {
    description = "whether to create the internet gateway"
    default     = false
    type        = bool
}

variable "nat_gateway_enabled" {
    description = "whether to create a nat gateway in the vcn"
    default     = false
    type        = bool
}

variable "service_gateway_enabled" {
    description = "whether to create a service gateway"
    default     = false
    type        = bool
}

variable "vcn_cidr" {
    description = "cidr block of VCN"
    default     = "10.0.0.0/16"
    type        = string
}

variable "vcn_dns_label" {
    description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet"
    type        = string
}

variable "vcn_name" {
    description = "user-friendly name of to use for the vcn to be appended to the label_prefix"
    type        = string
}

# Trivadis LAB specific parameter
variable "tvd_participants" {
    description = "The number of VCN to create"
    type        = number
    default     = 1
}

variable "tvd_domain" {   
    description = "The domain name of the LAB environment"
    type        = string
    default     = "trivadislabs.com" 
}

variable "tvd_dns1" {   
    description = "The DNS IP of the training environment"
    type        = string
    default     = "10.0.1.4" 
}

variable "tvd_dns2" {   
    description = "The DNS IP of the training environment"
    type        = string
    default     = "8.8.8.8" 
}
# - End of Input Variables --------------------------------------------------

# - Local Variables ---------------------------------------------------------
locals {
  vcn_shortname = replace(var.vcn_name, "-", "")
}
# - End of Local Variables --------------------------------------------------
# --- EOF -------------------------------------------------------------------