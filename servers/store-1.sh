# Store 1 - Devices 1, 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-1
export PRIMARY_BUILDER = https://ip-172-31-54-5.us-west-2.compute.internal/bldr/v1/

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/proxy 
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/instructions

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/build_package
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel production -workshop/deploy_rollback
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/cots
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel store-1 workshop/decentralized
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel store-1 --group store1 workshop/ring

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/smart_updates
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/host_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/host_configuration
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel stable workshop/app_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d1 --channel production workshop/jenkins

###--------------------------------------------------------------

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/proxy 
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/instructions

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/build_package
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel production -workshop/deploy_rollback
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/cots
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel store-1 workshop/decentralized
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel store-1 --group store1 workshop/ring

hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/smart_updates
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/host_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/host_configuration
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel stable workshop/app_compliance
hab svc load --url $PRIMARY_BUILDER --strategy at-once --update-condition track-channel --remote-sup s1d2 --channel production workshop/jenkins
