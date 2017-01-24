/* Copyright 2017 Your Name
*
* This file is part of Polkit Tutorial.
*
* Polkit Tutorial is free software: you can redistribute it
* and/or modify it under the terms of the GNU General Public License as
* published by the Free Software Foundation, either version 3 of the
* License, or (at your option) any later version.
*
* Polkit Tutorial is distributed in the hope that it will be
* useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
* Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with Polkit Tutorial. If not, see http://www.gnu.org/licenses/.
*/
public static int main (string[] args) {
  // Create the variables for the process execution
  string[] spawnArguments = {"pkexec", "/usr/bin/polkit-tutorial"};
  string[] spawnEnvironment = Environ.get ();
  string spawnStdOut;
  string spawnStdError;
  int spawnExitStatus;

  try {
    // Spawn the process synchronizedly
    // We do it synchronizedly because since we are just launching another process and such is the whole
    // purpose of this program, we don't want to exit this, the caller, since that will cause our spawned process to become a zombie.
    Process.spawn_sync ("/", spawnArguments, spawnEnvironment, SpawnFlags.SEARCH_PATH, null, out spawnStdOut, out spawnStdError, out spawnExitStatus);

    // Print the output if any
    stdout.printf ("Output: %s\n", spawnStdOut);
    // Print the error if any
    stderr.printf ("There was an error in the spawned process: %s\n", spawnStdError);
    // Print the exit status
    stderr.printf ("Exit status was: %d\n", spawnExitStatus);
  } catch (SpawnError spawnCaughtError) {
    stderr.printf ("There was an error spawining the process. Details: %s", spawnCaughtError.message);
  }

  return 0;
}
