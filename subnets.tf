# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: subnets.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Define subnets for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# ---------------------------------------------------------------------------
# create public subnet ------------------------------------------------------
resource "oci_core_subnet" "public_subnet" {
    count               = var.internet_gateway_enabled == true ? var.tvd_participants : 0
    compartment_id      = var.compartment_id
    cidr_block          = var.vcn_public_cidr
    display_name        = format(lower("${var.vcn_name}%02d public subnet"), count.index)
    dns_label           = "public"
    vcn_id              = oci_core_vcn.vcn.*.id[count.index]
    security_list_ids   = [oci_core_vcn.vcn.*.default_security_list_id[count.index]]
    route_table_id      = oci_core_vcn.vcn.*.default_route_table_id[count.index]
    dhcp_options_id     = oci_core_vcn.vcn.*.default_dhcp_options_id[count.index]
}

# create private subnet -----------------------------------------------------
resource "oci_core_subnet" "private_subnet" {
    count                       = var.nat_gateway_enabled == true ? var.tvd_participants : 0
    compartment_id              = var.compartment_id
    cidr_block                  = var.vcn_private_cidr
    display_name                = format(lower("${var.vcn_name}%02d private subnet"), count.index)
    dns_label                   = "private"
    prohibit_public_ip_on_vnic  = true
    vcn_id                      = oci_core_vcn.vcn.*.id[count.index]
    security_list_ids           = [oci_core_vcn.vcn.*.default_security_list_id[count.index]]
    route_table_id              = oci_core_route_table.private_route_table.*.id[count.index]
    dhcp_options_id             = oci_core_dhcp_options.private_dhcp_option.*.id[count.index]
}
# --- EOF -------------------------------------------------------------------