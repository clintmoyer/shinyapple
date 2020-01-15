/*
Copyright 2020 Clint Moyer

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/
import Foundation

let dockerRuntime = "/usr/local/bin/docker"

let fileManager = FileManager.default

if !fileManager.fileExists(atPath: dockerRuntime) {
	print("Missing Docker")
	exit(1)
}

var task = Process()
let pipe = Pipe()

// requires Mojave or newer TODO: handle older
task.standardOutput = pipe
task.executableURL = URL(fileURLWithPath: dockerRuntime)
task.arguments = ["ps", "-a", "-q"]

do {
	// requires Mojave or newer TODO: handle older
	try task.run()
} catch {
}

task.waitUntilExit()

// parse output to get array of containers
let data = pipe.fileHandleForReading.readDataToEndOfFile()
let output = String(data: data, encoding: String.Encoding.utf8)!
let lines = output.split { $0.isNewline }

// remove each container
//
// typically this clears data from /var/lib/docker/containers/
// MacOS kernel cannot run Docker natively, instead using a VM
// under $HOME/Library/Containers/com.docker.docker/Data
//
// ultimately this reduces the footprint of the Docker Machine

for container in lines {
	task = Process()
	task.executableURL = URL(fileURLWithPath: dockerRuntime)
	task.arguments = ["rm", String(container)]
	do {
		try task.run()
	} catch {
	}
	task.waitUntilExit()
}

