package main

import (
	"fmt"
	"os/exec"
	"strings"
	"net/http"
	"io/ioutil"
	"encoding/json"
	"strconv"
	//"regexp"
)

type Habitat interface {
	Status() []HabitatService
	Services() []SupervisorService
	Packages() HabitatPackageTree
	Versions() ServiceVersions
	Ring() ServiceRing

}

type engine struct {
}

func (e engine) Versions() ServiceVersions {
	var services = e.Status();
	results := ServiceVersions{};
	
	for _, svc := range services {
		ver := ServiceVersion{};

		ver.ID, _ = strconv.ParseInt(svc.Package.Build, 10, 64);
		ver.Name = svc.Package.Package;
		ver.Version = svc.Package.Version;
		ver.Build = svc.Package.Build;

		key := svc.Package.Package
		parts := strings.Split( svc.Package.Package, "_");
		if len(parts) > 1{
			idx := len(parts)-1;
			key = parts[idx];
		}
		results[key] = ver;
	}

	return results
}


func (e engine) Services() []SupervisorService {
	r, _ := http.Get("http://localhost:9631/services")
	jsonBytes, _ := ioutil.ReadAll(r.Body)

	var response []SupervisorService
	json.Unmarshal(jsonBytes, &response)

	return response;
}


func (e engine) Status() []HabitatService {
	out, err := exec.Command("hab", "svc", "status").Output()

	if err != nil {
		return []HabitatService{};
		fmt.Println(err.Error());
	}

	lines := strings.Split( strings.ReplaceAll(string(out), "\r\n", "\n"), "\n");
	lines = lines[1:];
	results := []HabitatService{}

	for _, line := range lines {
		svc := HabitatService{}
		parts := strings.Fields(line);

		if len(parts) == 7 {
			pkg := strings.Split(parts[0], "/");
			group := strings.Split(parts[6], ".");

			svc.Package = HabitatPackage{
				Origin: pkg[0],
				Package: pkg[1],
				Version: pkg[2],
				Build: pkg[3],
			};
			svc.Type = parts[1]
			svc.Desired = parts[2]
			svc.State = parts[3]
			svc.Elapsed = parts[4]
			svc.ProcessId = parts[5]
			svc.Group = ServiceGroup{
				Service: group[0],
				Group: group[1],
			};

			results = append(results, svc);
		}
	}
	return results;
}

func (e engine) Packages() HabitatPackageTree{
	out, err := exec.Command("hab", "pkg", "list", "--all").Output()

	if err != nil {
		return HabitatPackageTree{};
		fmt.Println(err.Error());
	}

	results := HabitatPackageTree{}
	
	lines := strings.Split( strings.ReplaceAll(string(out), "\r\n", "\n"), "\n");
	for _, line := range lines {
		parts := strings.Split(line, "/");
		if len(parts) == 4 {
			org := parts[0];
			pkg := parts[1];
			ver := parts[2];
			bld := parts[3];

			if _, ok := results[org]; !ok {
				results[org] =  make(map[string]map[string][]string);
			}

			if _, ok := results[org][pkg]; !ok {
				results[org][pkg] = make(map[string][]string);
			}

			if _, ok := results[org][pkg][ver]; !ok {
				results[org][pkg][ver] = []string{};
			}

			results[org][pkg][ver] = append(results[org][pkg][ver], bld);
		}
	}

	return results;
}

func (e engine) Ring() ServiceRing {
	r, _ := http.Get("http://localhost:9631/census")
	jsonBytes, _ := ioutil.ReadAll(r.Body)
	json := string(jsonBytes);
	response := ServiceRing{};

	response.Changed = Get(json, "changed").Bool();
	response.LocalMemberId = Get(json, "local_member_id").String();
	response.LastServiceCounter = Get(json, "last_service_counter").Int();
	response.LastElectionCounter = Get(json, "last_election_counter").Int();
	response.LastElectionUpdateCounter = Get(json, "last_election_update_counter").Int();
	response.LastMembershipCounter = Get(json, "last_membership_counter").Int();
	response.LastServiceConfigCounter = Get(json, "last_service_config_counter").Int();
	response.LastServiceFileCounter = Get(json, "last_service_file_counter").Int();

	response.Groups = make(map[string]CensusGroup);
	for gKey, cg := range Get(json, "census_groups").Map() {		
		group := CensusGroup{};
		group.ServiceGroup = Get(cg.Raw, "service_group").String();
		group.ElectionStatus = Get(cg.Raw, "election_status").String();
		group.UpdateElectionStatus = Get(cg.Raw, "update_election_status").String();
		group.PackageIncarnation = Get(cg.Raw, "pkg_incarnation").Int();
		group.LeaderID = Get(cg.Raw, "leader_id").String();
		group.ServiceConfig = Get(cg.Raw, "service_config").Value();
		group.LocalMemberId = Get(cg.Raw, "local_member_id").String();		
		group.UpdateLeaderId = Get(cg.Raw, "update_leader_id").String();

		for _, csf := range Get(cg.Raw, "changed_service_files").Map() {
			group.ChangedServiceFiles = append(group.ChangedServiceFiles, csf.String() );
		}

		group.Population = make(map[string]RingPopulation);
		for pKey, pop := range Get(cg.Raw, "population").Map() {
			population := RingPopulation{}

			population.MemberID = Get(pop.Raw, "member_id").String();
			population.Incarnation = Get(pop.Raw, "pkg_incarnation").Int();
			population.Ident = Get(pop.Raw, "package").String(); 
			population.Service = Get(pop.Raw, "service").String(); 
			population.Group = Get(pop.Raw, "group").String(); 
			population.Organization = Get(pop.Raw, "org").String(); 
			population.Persistent = Get(pop.Raw, "persistent").Bool();
			population.Leader = Get(pop.Raw, "leader").Bool(); 
			population.Follower = Get(pop.Raw, "follower").Bool(); 
			population.UpdateLeader = Get(pop.Raw, "update_leader").Bool(); 
			population.UpdateFollower = Get(pop.Raw, "update_follower").Bool();
			population.ElectionRunning = Get(pop.Raw, "election_is_running").Bool();
			population.ElectionNoQuorum = Get(pop.Raw, "election_is_no_quorum").Bool();
			population.ElectionFinished = Get(pop.Raw, "election_is_finished").Bool(); 
			population.UpdateElectionRunning = Get(pop.Raw, "update_election_is_running").Bool();
			population.UpdateElectionNoQuorum = Get(pop.Raw, "update_election_is_no_quorum").Bool();
			population.UpdateElectionFinished = Get(pop.Raw, "update_election_is_finished").Bool();
			population.Alive = Get(pop.Raw, "alive").Bool(); 
			population.Suspect = Get(pop.Raw, "suspect").Bool();
			population.Confirmed = Get(pop.Raw, "confirmed").Bool();
			population.Departed = Get(pop.Raw, "departed").Bool(); 

			population.Package.Origin = Get(pop.Raw, "pkg.origin").String(); 
			population.Package.Package = Get(pop.Raw, "pkg.name").String(); 
			population.Package.Version = Get(pop.Raw, "pkg.version").String(); 
			population.Package.Build = Get(pop.Raw, "pkg.release").String(); 

			population.System.IP = Get(pop.Raw, "sys.ip").String();
			population.System.Hostname = Get(pop.Raw, "sys.hostname").String();
			population.System.GossipIP = Get(pop.Raw, "sys.gossip_ip").String(); 
			population.System.GossipPort = Get(pop.Raw, "sys.gossip_port").Int();
			population.System.HttpGatewayIp = Get(pop.Raw, "sys.http_gateway_ip").String();
			population.System.HttpGatewayPort = Get(pop.Raw, "sys.http_gateway_port").Int();
			population.System.CommandGatewayIp = Get(pop.Raw, "sys.ctl_gateway_ip").String();
			population.System.CommandGatewayPort = Get(pop.Raw, "sys.ctl_gateway_port").Int();

			//population.Config map[string]interface{} `json:"config"` //cfg
			group.Population[pKey] = population;
		}
		group.Self = group.Population[group.LocalMemberId];

		response.Groups[gKey] = group;

		//key
		//group.XXXXXXXX = Get(cg_json, "XXXXXXXXXXX").XXXXXXX();
		
		//group.
		/*
	Population map[string]RingPopulation `json:"population"` //census_groups

	ServiceFiles map[string]interface{} `json:"serviceFiles"` //service_files
	Self RingPopulation `json:"self"` //census_groups
*/
	}
	return response;
}