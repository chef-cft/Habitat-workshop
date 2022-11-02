# Store 3 - Device 1, Device 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-3


hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel stable workshop/proxy
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel stable workshop/instructions

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel stable workshop/build_package
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel dev workshop/deploy_rollback
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel stable workshop/cots
hab svc load --url $LOCAL_BUILDER   --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel store-3 workshop/decentralized
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel store-3 --group store3 workshop/ring

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel stable --shutdown-timeout 600 workshop/smart_updates
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel s3d1 workshop/host_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel s3d1 workshop/host_configuration
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel s3d1 workshop/app_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d1 --channel dev workshop/jenkins

# devices 2

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel stable workshop/proxy
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel stable workshop/instructions

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel stable workshop/build_package
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel dev workshop/deploy_rollback
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel stable workshop/cots
hab svc load --url $LOCAL_BUILDER   --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel store-3 workshop/decentralized
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel store-3 --group store3 workshop/ring

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel stable --shutdown-timeout 600 workshop/smart_updates
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel s3d2 workshop/host_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel s3d2 workshop/host_configuration
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel s3d2 workshop/app_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s3d2 --channel dev workshop/jenkins
