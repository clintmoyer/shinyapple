/*
Copyright 2020 Clint Moyer

This file is part of ShinyApple.

ShinyApple is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ShinyApple is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with ShinyApple.  If not, see <https://www.gnu.org/licenses/>.
*/
import Commander


command(
  Option("name", default: "world"),
  Option("count", default: 1, description: "The number of times to print.")
) { name, count in
  for _ in 0..<count {
    print("Hello \(name)")
  }
}

// docker
print("Cleaning up Docker")
dockerCleanup()

// brew
print("Cleaning up Brew")
brewCleanup()

// cleanup memory
print("Cleaning up memory")
memoryCleanup()
