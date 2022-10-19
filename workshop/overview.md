# Workshop

## Module 1
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