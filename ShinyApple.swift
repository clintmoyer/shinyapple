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
import Foundation

let dockerRuntime = "/usr/local/bin/docker"

func checkDocker() {
	let fileManager = FileManager.default
	if !fileManager.fileExists(atPath: dockerRuntime) {
		print("Missing Docker")
		exit(1)
	}
}

// docker ps -aq
func getContainers() -> Array<String.SubSequence> {
	let task = Process()
	let pipe = Pipe()

	task.standardOutput = pipe
	task.executableURL = URL(fileURLWithPath: dockerRuntime)
	task.arguments = ["ps", "-a", "-q"]

	do {
		try task.run()
	} catch {
	}

	task.waitUntilExit()

	let data = pipe.fileHandleForReading.readDataToEndOfFile()
	let output = String(data: data, encoding: String.Encoding.utf8)!
	let containers = output.split { $0.isNewline }

	return containers
}

// docker rm <container>
//
// typically this clears data from /var/lib/docker/containers/
// MacOS kernel cannot run Docker natively, instead using a VM
// under $HOME/Library/Containers/com.docker.docker/Data
//
// ultimately this reduces the footprint of the Docker Machine
func removeContainer(container: String.SubSequence) {
	let task = Process()
	task.executableURL = URL(fileURLWithPath: dockerRuntime)
	task.arguments = ["rm", String(container)]
	do {
		try task.run()
	} catch {
	}
	task.waitUntilExit()
}

