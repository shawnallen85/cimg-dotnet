<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://raw.github.com/CircleCI-Public/cimg-base/master/img/circle-circleci.svg?sanitize=true" width="75" />
		<img alt="Docker Logo" src="https://raw.github.com/CircleCI-Public/cimg-base/master/img/circle-docker.svg?sanitize=true" width="75" />
		<img alt=".NET Logo" src="https://raw.github.com/dotnet/brand/master/logo/dotnet-logo.svg?sanitize=true" width="75" />
	</p>
	<h1>CircleCI Convenience Images => .NET</h1>
	<h3>A Continuous Integration focused .NET Container image built to run on CircleCI</h3>
</div>

![Software License](https://img.shields.io/badge/license-MIT-blue.svg)

`cimg/dotnet` is a Docker image created by Shawn Black with continuous integration builds in mind.
Each tag contains a complete .NET SDK and any binaries and tools that are required for builds to complete successfully in a CircleCI environment.

## Table of Contents

- [Getting Started](#getting-started)
- [How This Image Works](#how-this-image-works)
- [Development](#development)
- [Contributing](#contributing)
- [Additional Resources](#additional-resources)
- [License](#license)

## Getting Started

This image can be used with the CircleCI `docker` executor.
For example:

```yaml
jobs:
  build:
    docker:
      - image: cimg/dotnet:6.0
    steps:
      - checkout
      - run: dotnet --version
```

In the above example, the CircleCI .NET Docker image is used for the primary container.
More specifically, the tag `6.0` is used meaning the version of .NET will be .NET 6.0.
You can now use .NET within the steps for this job.

## How This Image Works

This image contains the .NET SDK and its complete toolchain.

### Variants

Variant images typically contain the same base software, but with a few additional modifications.

#### Node.js

The Node.js variant is the same .NET image but with Node.js also installed.
The Node.js variant will be used by appending `-node` to the end of an existing `cimg/dotnet` tag.

```yaml
jobs:
  build:
    docker:
      - image: cimg/dotnet:6.0-node
    steps:
      - checkout
      - run: dotnet --version
      - run: node --version
```

#### Browsers

The browsers variant is the same .NET image but with Node.js, Java, Selenium, and browser dependencies pre-installed via apt.
The browsers variant can be used by appending `-browser` to the end of an existing `cimg/dotnet` tag.
The browsers variant is designed to work in conjunction with the [CircleCI Browser Tools orb](https://circleci.com/developer/orbs/orb/circleci/browser-tools).
You can use the orb to install a version of Google Chrome and/or Firefox into your build. The image contains all of the supporting tools needed to use both the browser and its driver.

```yaml
orbs:
  browser-tools: circleci/browser-tools@1.1
jobs:
  build:
    docker:
      - image: cimg/dotnet:6.0-browsers
    steps:
      - browser-tools/install-browser-tools
      - checkout
      - run: |
          dotnet --version
          node --version
          java --version
          google-chrome --version
```

### Tagging Scheme

This image has the following tagging scheme:

```
cimg/dotnet:<dotnet-version>[-variant]
```

`<dotnet-version>` - The version of .NET to use.
This can be the minor release (such as `6.0`).

`[-variant]` - Variant tags, if available, can optionally be used.
Once the Node.js variant is available, it could be used like this: `cimg/dotnet:6.0-node`.

## Development

Images can be built and run locally with this repository.
This has the following requirements:

- local machine of Linux (Ubuntu tested) or macOS
- modern version of Bash (v4+)
- modern version of Docker Engine (v19.03+) or Buildah (tested with v1.21.3)

### Cloning For Community Users (no write access to this repository)

Fork this repository on GitHub.
When you get your clone URL, you'll want to add `--recurse-submodules` to the clone command in order to populate the Git submodule contained in this repo.
It would look something like this:

```bash
git clone --recurse-submodules <my-clone-url>
```

If you missed this step and already cloned, you can just run `git submodule update --recursive` to populate the submodule.
Then you can optionally add this repo as an upstream to your own:

```bash
git remote add upstream https://github.com/shawnallen85/cimg-dotnet.git
```

### Cloning For Maintainers (you have write access to this repository)

Clone the project with the following command so that you populate the submodule:

```bash
git clone --recurse-submodules git@github.com:shawnallen85/cimg-dotnet.git
```

### Generating Dockerfiles

Dockerfiles can be generated for a specific .NET version using the `gen-dockerfiles.sh` script.
For example, to generate the Dockerfile for .NET v5.0, you would run the following from the root of the repo:

```bash
./shared/gen-dockerfiles.sh 5.0
```

The generated Dockerfile will be located at `./5.0/Dockefile`.
To build this image locally and try it out, you can run the following:

```bash
cd 5.0
docker build -t test/dotnet:5.0 .
docker run -it test/dotnet:5.0 bash
```

### Building the Dockerfiles

To build the Docker images locally as this repository does, you'll want to run the `build-images.sh` script:

```bash
./build-images.sh
```

This would need to be run after generating the Dockerfiles first.

When releasing proper images for CircleCI, this script is run from a CircleCI pipeline and not locally.

### Publishing Official Images (for Maintainers only)

The individual scripts (above) can be used to create the correct files for an image, and then added to a new git branch, committed, etc.
A release script is included to make this process easier.
To make a proper release for this image, let's use the fake .NET version of .NET v9.99, you would run the following from the repo root:

```bash
./shared/release.sh 9.99
```

This will automatically create a new Git branch, generate the Dockerfile(s), stage the changes, commit them, and push them to GitHub.
The commit message will end with the string `[release]`.
This string is used by CircleCI to know when to push images to Docker Hub.
All that would need to be done after that is:

- wait for build to pass on CircleCI
- review the PR
- merge the PR

The master branch build will then publish a release.

### Incorporating Changes

How changes are incorporated into this image depends on where they come from.

**build scripts** - Changes within the `./shared` submodule happen in its [own repository](https://github.com/CircleCI-Public/cimg-shared).
For those changes to affect this image, the submodule needs to be updated.
Typically like this:

```bash
cd shared
git pull
cd ..
git add shared
git commit -m "Updating submodule for foo."
```

**parent image** - By design, when changes happen to a parent image, they don't appear in existing .NET images.
This is to aid in "determinism" and prevent breaking customer builds.
New .NET images will automatically pick up the changes.

If you *really* want to publish changes from a parent image into the .NET image, you have to build a specific image version as if it was a new image.
This will create a new Dockerfile and once published, a new image.

## Additional Resources

[CircleCI Docs](https://circleci.com/docs/) - The official CircleCI Documentation website.
[CircleCI Configuration Reference](https://circleci.com/docs/2.0/configuration-reference/#section=configuration) - From CircleCI Docs, the configuration reference page is one of the most useful pages we have.
It will list all of the keys and values supported in `.circleci/config.yml`.
[Docker Docs](https://docs.docker.com/) - For simple projects this won't be needed but if you want to dive deeper into learning Docker, this is a great resource.

## License

This repository is licensed under the MIT license.
The license can be found [here](./LICENSE).
