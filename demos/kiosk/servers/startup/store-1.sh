# Store 1 - Devices 1, 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-1

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable kiosk/kiosk_proxy 

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable --shutdown-timeout 600 kiosk/kiosk_ui
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel production kiosk/kiosk_cart
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable kiosk/kiosk_processor
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel store-1 kiosk/kiosk_store
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel store-1 --group store1 kiosk/kiosk_inventory

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable kiosk/kiosk_meta
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel s1d1 kiosk/kiosk_coupons
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel s1d1 kiosk/kiosk_hostCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel s1d1 kiosk/kiosk_appCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel production kiosk/kiosk_hostConfig
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel production kiosk/kiosk_discover

###--------------------------------------------------------------
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable kiosk/kiosk_proxy 

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable --shutdown-timeout 600 kiosk/kiosk_ui
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel production kiosk/kiosk_cart
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable kiosk/kiosk_processor
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel store-1 kiosk/kiosk_store
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel store-1 --group store1 kiosk/kiosk_inventory

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable kiosk/kiosk_meta
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel s1d1 kiosk/kiosk_coupons
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel s1d1 kiosk/kiosk_hostCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel s1d1 kiosk/kiosk_appCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel production kiosk/kiosk_hostConfig
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel production kiosk/kiosk_discover