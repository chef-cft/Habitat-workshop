# Store 2 - Devices 1
# PRIMARY_BUILDER = the automate builder
# LOCAL_BUILDER = the remote builder
# default channel stable
# deploy_rollback, jenkins - Channel: production
# decentralized, ring - Channel: store-2

hab svc unload --remote-sup s2d1 workshop/proxy 
hab svc unload --remote-sup s2d1 workshop/instructions

hab svc unload --remote-sup s2d1 workshop/build_package
hab svc unload --remote-sup s2d1 workshop/deploy_rollback
hab svc unload --remote-sup s2d1 workshop/cots
hab svc unload --remote-sup s2d1 workshop/decentralized
hab svc unload --remote-sup s2d1 workshop/ring

hab svc unload --remote-sup s2d1 workshop/smart_updates
hab svc unload --remote-sup s2d1 workshop/host_compliance
hab svc unload --remote-sup s2d1 workshop/host_configuration
hab svc unload --remote-sup s2d1 workshop/app_compliance
hab svc unload --remote-sup s2d1 workshop/jenkins