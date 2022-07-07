# AsanaBot

Command line app for GitHub/Asana/Slack integration

### Stack

- command line app written in Swift
- packaged using Docker for actions container runtime
- triggered using Github Actions on PR ([see example](./.github/workflows/move-tag.yml))

##### Packaging

Cutting a release on GitHub will trigger a new docker build and upload to ghcr.io with appropriate tags. Manual build/push can be done with `docker build -t hiimtmac/asana-bot --push .` but GitHub actions needs to run on amd64 based images. If the build is done via GitHub actions that is fine, if you have an arm64 based machine you will need to run `docker buildx build --platform linux/amd64 -t hiimtmac/asana-bot --push .` or use the provided `build.sh` script.

### Flows

##### PR create/update

- Capture Asana tasks in triggering PR body by regex
- Search for section in Asana called 'In Progress'
- If section found, move task to section

##### PR ready for review/review requested

- Capture Asana tasks in triggering PR body by regex
- Search for section in Asana called 'Ready for Review'
- If section found, move task to section

##### PR Merged

- Capture Asana tasks in triggering PR body by regex
- Search for section in Asana called 'Merged'
- If section found, move task to section
- Notify Slack with markdown block of PR body

### Notes

- Uses both GitHub and Asana APIs so possibilities are endless
- Requires no change to current flow
- Can manually move tasks around to other sections and it wont "break"

### TODO

- [ ] Implement Oauth for Asana instead of using PAT
- [ ] New Swift regex builder when 5.7 is released
- [ ] New date formatters when 5.7 is released
- [ ] Switch formatter to `swift-format` from `swiftformat`
- [ ] Change section fetching to batch
