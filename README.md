# Habitat Workshop


## Tasks In Flight

- [x] Workstation installation
- [x] Automate/primary builder install
- [x] primary builder core bootstrap
- [x] Store 1 Device 1 created
- [ ] Create supervisor ring
- [ ] Create secondary builder
- [ ] Setup Builder sync
- [ ] Create Jenkins instance
- [ ] Setup demo application
- [ ] Create DNS Entries
- [ ] Create AMIs
- [ ] Update cloud formation scripts

## Components

### Workstation
The primary workstation is an openvscode server which is accessible via a web browser at [http://hws-workstation.chef-demo.com](http://hws-workstation.chef-demo.com:3000/?f4e1d044-f420-4342-af66-f3ca098e9c46).  Within VS Code you should be able to open the /home/ubuntu/workspace directory which includes all of the files needed for a workshop/demo.  In addition, this host has aliases created for all of the supervisors to make it easier to use remote supervisor commands.  To use just reference one of the items below (ex. hab svc status --remote-sup=s1d1).

| Alias | Description |
| ---- | ------- |
| s1d1 | Store 1 Device 1 |
| s1d2 | Store 1 Device 2 |
| s2d1 | Store 2 Device 1 |
| s3d1 | Store 3 Device 1 |
| s3d2 | Store 3 Device 1 |