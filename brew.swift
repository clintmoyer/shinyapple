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


let brewRuntime = "/usr/local/bin/brew"


// warn us when Docker is not present
func checkBrew() {
	let fileManager = FileManager.default
	if !fileManager.fileExists(atPath: brewRuntime) {
		print("Missing Brew")
		exit(1)
	}
}

func brewCleanup() {
	let task = Process()
	let pipe = Pipe()

	task.standardOutput = pipe
	task.executableURL = URL(fileURLWithPath: brewRuntime)
	task.arguments = ["cleanup"]

	do {
		try task.run()
	} catch {
	}

	task.waitUntilExit()

}
