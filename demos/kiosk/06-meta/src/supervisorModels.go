package main

type SupervisorServiceDependency struct {
	Origin string `json:"origin"`
	Name string `json:"name"`
	Version string `json:"version"`
	Release string `json:"release"`
}

type SupervisorProcess struct {
	ProcessId int `json:"pid"`
	State string `json:"state"`
	StateEntered int `json:"state_entered"`
}


type SupervisorProcessState struct {
	ProcessId int `json:"pid"`
	Reason string `json:"termination_reason"`
	TerminatedAt int `json:"terminated_at"`
}

type SupervisorServiceHooks struct {
	HealthCheck string `json:"health_check"`
	Init string `json:"init"`
	FileUpdated string `json:"file_updated"`
	Reload string `json:"reload"`
	Reconfigure string `json:"reconfigure"`
	Suitability string `json:"suitability"`
	Run string `json:"run"`
	PostRun string `json:"post_run"`
	PostStop string `json:"post_stop"`
}

type SupervisorHealthChecks struct {
	Seconds int `json:"secs"`
	NanoSeconds int `json:"nanos"`
}

type SupervisorSystemInformation struct {
	Version string `json:"version"`
	MemberId string `json:"member_id"`
	Ip string `json:"ip"`
	Hostname string `json:"hostname"`
	GossipIp string `json:"gossip_ip"`
	GossipPort int `json:"gossip_port"`
	RemoteControlGatewayIp string `json:"ctl_gateway_ip"`
	RemoteControlGatewayPort int `json:"ctl_gateway_port"`
	HttpGatewayIp string `json:"http_gateway_ip"`
	HttpGatewayPort int `json:"http_gateway_port"`
	Permanent bool `json:"permanent"`
}

type SupervisorServicePackage struct {
	Ident string `json:"ident"`
	Origin string `json:"origin"`
	Name string `json:"name"`
	Bersion string `json:"version"`
	Release string `json:"release"`
	Deps []SupervisorServiceDependency `json:"deps"`
	Dependencies []string `json:"dependencies"`
	Env map[string]interface{}  `json:"env"`
//	exposes map[string]interface{}  `json:"exposes"`
//	exports map[string]interface{}  `json:"exports"`
	Path string `json:"path"`
	ServicePath string `json:"svc_path"`
	ServiceConfigPath string `json:"svc_config_path"`
	ServiceConfigInstallPath string `json:"svc_config_install_path"`
	ServiceDataPath string `json:"svc_data_path"`
	ServiceFilesPath string `json:"svc_files_path"`
	ServiceStaticPath string `json:"svc_static_path"`
	ServiceVarPath string `json:"svc_var_path"`
	ServicePidFile string `json:"svc_pid_file"`
	ServiceRun string `json:"svc_run"`
	ServiceUser string `json:"svc_user"`
	ServiceGroup string `json:"svc_group"`
	ShutdownSignal string `json:"shutdown_signal"`
	ShutdownTimeout int `json:"shutdown_timeout"`
}


type SupervisorService struct {
	AllPackageBinds map[string]interface{} `json:"all_pkg_binds"`
	BindingMode string `json:"binding_mode"`
	Binds map[string]interface{} `json:"binds"`
	BuilderUrl string `json:"bldr_url"`
	//Config map[string]interface{}  `json:"cfg"`
	ConfigFrom string `json:"config_from"`
	DesiredState string `json:"desired_state"`
	HealthCheck string `json:"health_check"`
	Hooks SupervisorServiceHooks `json:"hooks"`
	Initialized bool `json:"initialized"`
	LastElectionStatus bool `json:"last_election_status"`
	//ManagerFileSystemConfig map[string]interface{} `json:"manager_fs_cfg"`
	Package SupervisorServicePackage `json:"pkg"`
	Process SupervisorProcess `json:"process"`
	//NextRestartAt string `json:"next_restart_at"`
	RestartCount int `json:"restart_count"`
	RestartConfig map[string]interface{} `json:"restart_config"`
	ServiceGroup string `json:"service_group"`
	SpecFile string `json:"spec_file"`
	SpecIdent SupervisorServiceDependency `json:"spec_ident"`
	SpecIdentifier string `json:"spec_identifier"`
	//svc_encrypted_password string `json:"svc_encrypted_password"`
	HealthCheckInterval SupervisorHealthChecks `json:"health_check_interval"`
	SystemInfo SupervisorSystemInformation `json:"sys"`
	Topology string `json:"topology"`
	UpdateStrategy string `json:"update_strategy"`
	UpdateCondition string `json:"update_condition"`
	UserConfigUpdated bool `json:"user_config_updated"`

}
