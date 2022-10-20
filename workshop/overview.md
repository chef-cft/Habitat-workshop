# Workshop

## Module 1 - Build & Package
1. within VS Code open up the /home/ubuntu/workshop and open up a new terminal (Menu Button -> Terminal -> New Terminal ) 
2. run git clone https://github.com/habitat-sh/sample-node-app.git
3. cd into the sample-node-app directory
4. Open up habitat/plan.sh and walk through plan files and their components (such as hooks)
5. Change the origin to "edge"
6. from the sample-node-app directory run hab studio enter
7. Within the studio run build, then exit builder once completed
8. Walk through the results directory, heart file, and the output of the build
9. run source results/last_build.env
10.  run hab pkg upload results/$pkg_artifact
11. Explain Origin, Origin keys, signing
12. Open browser, navigate to [bldr](https://hws-automate.chef-demo.com/bldr/), and sign in
13.  Navigate to edge origin, explain channels, package versioning,etc

## Module 2 - Promotion & Rollback
1. Explain unstable vs stable, deployable vs non-deployable
2. run hab pkg promote edge/sample-node-app/1.1.0/PACKAGE_DATE  test to promote to test channel 
3. In bldr, promote the package to stable
3. Run hab svc load edge/sample-node-app --channel=test --group dev --strategy at-once --update-condition track-channel --remote-sup=s1d1