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


// use MacOS purge tool
func memoryCleanup() {
	if !checkRoot() {
		print("Not running as root")
		return
	}

	let task = Process()

	task.executableURL = URL(fileURLWithPath: "/usr/sbin/purge")

	do {
		try task.run()
	} catch {
	}

	task.waitUntilExit()
}

// check if running as root
func checkRoot() -> Bool {
	if geteuid() == 0 {
		return true
	} else {
		return false
	}
}

