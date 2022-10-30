# Store 3 - Device 1, Device 2
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-3

hab svc unload --remote-sup s3d1 --channel stable workshop/proxy 
hab svc unload --remote-sup s3d1 --channel stable workshop/instructions

hab svc unload --remote-sup s3d1 --channel stable workshop/build_package
hab svc unload --remote-sup s3d1 --channel production -workshop/deploy_rollback
hab svc unload --remote-sup s3d1 --channel stable workshop/cots
hab svc unload --remote-sup s3d1 --channel store-1 workshop/decentralized
hab svc unload --remote-sup s3d1 --channel store-1 --group store1 workshop/ring

hab svc unload --remote-sup s3d1 --channel stable --shutdown-timeout 600 workshop/smart_updates
hab svc unload --remote-sup s3d1 --channel stable workshop/host_compliance
hab svc unload --remote-sup s3d1 --channel stable workshop/host_configuration
hab svc unload --remote-sup s3d1 --channel stable workshop/app_compliance
hab svc unload --remote-sup s3d1 --channel production workshop/jenkins

# devices 2

hab svc unload --remote-sup s3d2 --channel stable workshop/proxy 
hab svc unload --remote-sup s3d2 --channel stable workshop/instructions

hab svc unload --remote-sup s3d2 --channel stable workshop/build_package
hab svc unload --remote-sup s3d2 --channel production -workshop/deploy_rollback
hab svc unload --remote-sup s3d2 --channel stable workshop/cots
hab svc unload --remote-sup s3d2 --channel store-1 workshop/decentralized
hab svc unload --remote-sup s3d2 --channel store-1 --group store1 workshop/ring

hab svc unload --remote-sup s3d2 --channel stable --shutdown-timeout 600 workshop/smart_updates
hab svc unload --remote-sup s3d2 --channel stable workshop/host_compliance
hab svc unload --remote-sup s3d2 --channel stable workshop/host_configuration
hab svc unload --remote-sup s3d2 --channel stable workshop/app_compliance
hab svc unload --remote-sup s3d2 --channel production workshop/jenkins
