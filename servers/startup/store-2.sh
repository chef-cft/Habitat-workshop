# Store 2 - Device 1
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-2
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable workshop/proxy
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable workshop/instructions

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable workshop/build_package
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel qa workshop/deploy_rollback
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable workshop/cots
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel store-2 workshop/decentralized
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel store-2 --group store2 workshop/ring

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel stable --shutdown-timeout 600 workshop/smart_updates
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 workshop/host_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 workshop/host_configuration
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel s2d1 workshop/app_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s2d1 --channel qa workshop/jenkins