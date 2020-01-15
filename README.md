# ShinyApple

Cleanup your MacOS system

## Building

```
$ swiftc *.swift -o shinyapple
```

## Notes

*  using `Foundation.Process()` rather than the Docker socket API because unable to find a stable socket library to use it
*  requires MacOS Mojave or newer to use updated libraries

