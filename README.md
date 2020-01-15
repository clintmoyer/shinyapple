# ShinyApple

Cleanup your MacOS system

## Actions

*  `` docker rm `docker ps -aq` ``
*  `brew cleanup`
*  `purge` (MacOS memory tool)

## Building

```
$ swiftc *.swift -o shinyapple
```

## Limitations

*  using `Foundation.Process()` rather than the Docker socket API because unable to find a stable socket library to use it
*  `Process.run()` requires MacOS Mojave or newer

