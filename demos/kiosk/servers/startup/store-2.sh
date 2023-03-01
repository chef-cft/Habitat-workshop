# Store 2 - Device 1
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-2

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable kiosk/kiosk_proxy 

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable --shutdown-timeout 600 kiosk/kiosk_ui
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel production kiosk/kiosk_cart
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable kiosk/kiosk_processor
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel store-2 --group store2 kiosk/kiosk_store
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel store-2 --group store2 kiosk/kiosk_inventory

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable kiosk/kiosk_meta
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 kiosk/kiosk_coupons
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 kiosk/kiosk_hostCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 kiosk/kiosk_appCompliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel production kiosk/kiosk_hostConfig
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel production kiosk/kiosk_discover
