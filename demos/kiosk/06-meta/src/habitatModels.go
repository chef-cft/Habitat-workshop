package main

type HabitatPackage struct {
	Origin string `json:"origin"`
	Package string `json:"package"`
	Version string `json:"version"`
	Build string `json:"build"`
}

type ServiceGroup struct {
	Service string `json:"service"`
	Group string `json:"group"`
}

type HabitatService struct {
	Package HabitatPackage `json:"package"`
	Type string `json:"type"`
	Desired string `json:"desired"`
	State string `json:"state"`
	Elapsed string `json:"elapsed"`
	ProcessId string `json:"pid"`
	Group ServiceGroup `json:"serviceGroup"`
}

type ServiceVersion struct {
	ID int64 `json:"id"`
	Name string `json:"name"`
	Version string `json:"version"`
	Build string `json:"build"`
}

type HabitatPackageTree map[string]map[string]map[string][]string
type ServiceVersions map[string]ServiceVersion

type RingSystem struct {
	IP string `json:"ip"` //ip
	Hostname string `json:"hostname"` //hostname
	GossipIP string `json:"gossipIp"` //gossip_ip
	GossipPort int64 `json:"gossipPort"` //gossip_port
	HttpGatewayIp string `json:"httpGatewayIp"` //http_gateway_ip
	HttpGatewayPort int64 `json:"httpGatewayPort"` //http_gateway_port
	CommandGatewayIp string `json:"commandGatewayIp"` //ctl_gateway_ip
	CommandGatewayPort int64 `json:"commandGatewayPort"` //ctl_gateway_port
}

type RingPopulation struct {
	MemberID string `json:"memberId"` //member_id
	Package HabitatPackage `json:"package"` //pkg
	Incarnation int64 `json:"incarnation"` //pkg_incarnation
	Ident string `json:"ident"` //package
	Service string `json:"service"` //org
	Group string `json:"group"` //group
	Organization string `json:"organization"` //org
	Persistent bool `json:"persistent"` //persistent
	Leader bool `json:"leader"` //leader
	Follower bool `json:"follower"` //follower
	UpdateLeader bool `json:"updateLeader"` //update_leader
	UpdateFollower bool `json:"updateFollower"` //update_follower
	ElectionRunning bool `json:"electionRunning"` //election_is_running
	ElectionNoQuorum bool `json:"electionNoQuorum"` //election_is_no_quorum
	ElectionFinished bool `json:"electionFinished"` //election_is_finished
	UpdateElectionRunning bool `json:"updateElectionRunning"` //update_election_is_running
	UpdateElectionNoQuorum bool `json:"updateElectionNoQuorum"` //update_election_is_no_quorum
	UpdateElectionFinished bool `json:"updateElectionFinished"` //update_election_is_finished
	System RingSystem `json:"system"` //sys
	Alive bool `json:"alive"` //alive
	Suspect bool `json:"suspect"` //suspect
	Confirmed bool `json:"confirmed"` //confirmed
	Departed bool `json:"departed"` //departed
	Config map[string]interface{} `json:"config"` //cfg
}


type CensusGroup struct {
	ServiceGroup string `json:"serviceGroup"` //service_group
	ElectionStatus string `json:"electionStatus"` //election_status
	UpdateElectionStatus string `json:"updateElectionStatus"` //update_election_status
	PackageIncarnation int64 `json:"packageIncarnation"` //pkg_incarnation
	LeaderID string `json:"leaderID"` //leader_id
	ServiceConfig interface{} `json:"serviceConfig"` //service_config
	LocalMemberId string `json:"localMemberId"` //local_member_id
	Population map[string]RingPopulation `json:"population"` //population
	Self RingPopulation `json:"self"` //census_groups
	UpdateLeaderId string `json:"UpdateLeaderId"` //update_leader_id
	ChangedServiceFiles []string `json:"changedServiceFiles"` //changed_service_files
	ServiceFiles map[string]interface{} `json:"serviceFiles"` //service_files
}

type ServiceRing struct {
	Changed bool `json:"changed"`	
	Groups map[string]CensusGroup `json:"censusGroups"` //census_groups
	LocalMemberId string `json:"localMemberId"` //local_member_id
	LastServiceCounter int64 `json:"lastServiceCounter"` //last_service_counter
	LastElectionCounter int64 `json:"lastElectionCounter"` //last_election_counter
	LastElectionUpdateCounter int64 `json:"lastElectionUpdateCounter"` //last_election_update_counter
	LastMembershipCounter int64 `json:"lastMembershipCounter"` //last_membership_counter
	LastServiceConfigCounter int64 `json:"lastServiceConfigCounter"` //last_service_config_counter
	LastServiceFileCounter int64 `json:"lastServiceFileCounter"` //last_service_file_counter
}