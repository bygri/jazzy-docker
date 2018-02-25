# Dockerfile for Jazzy on Linux

This image runs Jazzy, the Swift documentation generator, in a Linux Docker container for SPM projects. Because why not.

## Usage

Warning: it's a bit fiddly. Once you have a working run command, you might want to save it as a one-liner terminal script.

1. You *must* have first built your module in Linux (e.g. via another Docker container).

2. You *must* mount (`-v`) your project folder in the Jazzy container under the same path as your build container from 1,
   and tell the Jazzy container (`-w`) where you mounted it.

`docker run -e MODULE=[MySwiftModule] -w [MyProjectPath] -v "$PWD:[MyProjectPath]" bygri/jazzy`

For example, if you build your Swift module named `MyApp` in the path `/app`, this would be your run command:

`docker run -e MODULE=MyApp -w /app -v "$PWD:/app" bygri/jazzy`

Your docs will arrive in the `./docs` folder.

## Customising your Jazzy docs

Create a `.jazzy.yaml` file with your custom config.
