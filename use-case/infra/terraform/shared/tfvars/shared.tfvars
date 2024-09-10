project = "poab-demo"
location = "northeurope"
location_short_name = "ne"

vnet_address_prefixes = [
    "10.0.0.0/24"
]
snet_vm_address_prefixes = [
    "10.0.0.0/27"
]

jumphost_vm_size = "Standard_B1s"
jumphost_vm_admin_username = "jumper"
jumphost_vm_admin_password = "P@ssword1234!"

cr_sku = "Basic"
cr_admin_enabled = true