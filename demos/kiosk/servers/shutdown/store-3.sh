# Store 3 - Devices 1, 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-3
# Store 1 - Devices 1, 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-1

hab svc unload --remote-sup s3d1 kiosk/kiosk_proxy 

hab svc unload --remote-sup s3d1 kiosk/kiosk_ui
hab svc unload --remote-sup s3d1 kiosk/kiosk_cart
hab svc unload --remote-sup s3d1 kiosk/kiosk_processor
hab svc unload --remote-sup s3d1 kiosk/kiosk_store
hab svc unload --remote-sup s3d1 kiosk/kiosk_inventory

hab svc unload --remote-sup s3d1 kiosk/kiosk_meta
hab svc unload --remote-sup s3d1 kiosk/kiosk_coupons
hab svc unload --remote-sup s3d1 kiosk/kiosk_hostCompliance
hab svc unload --remote-sup s3d1 kiosk/kiosk_appCompliance
hab svc unload --remote-sup s3d1 kiosk/kiosk_hostConfig
hab svc unload --remote-sup s3d1 kiosk/kiosk_discover

###--------------------------------------------------------------
hab svc unload --remote-sup s3d2 kiosk/kiosk_proxy 

hab svc unload --remote-sup s3d2 kiosk/kiosk_ui
hab svc unload --remote-sup s3d2 kiosk/kiosk_cart
hab svc unload --remote-sup s3d2 kiosk/kiosk_processor
hab svc unload --remote-sup s3d2 kiosk/kiosk_store
hab svc unload --remote-sup s3d2 kiosk/kiosk_inventory

hab svc unload --remote-sup s3d2 kiosk/kiosk_meta
hab svc unload --remote-sup s3d2 kiosk/kiosk_coupons
hab svc unload --remote-sup s3d2 kiosk/kiosk_hostCompliance
hab svc unload --remote-sup s3d2 kiosk/kiosk_appCompliance
hab svc unload --remote-sup s3d2 kiosk/kiosk_hostConfig
hab svc unload --remote-sup s3d2 kiosk/kiosk_discover
