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
using Gtk;
public class PolkitTutorialApplication : Gtk.Application {

    public PolkitTutorialApplication () {
        Object (application_id: "polkit.tutorial",
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        // The main window with its title and size
        var window = new Gtk.ApplicationWindow (this);
        window.title = "Polkit tutorial";

        // The buttons container
        Box buttonsBox = new Box (Gtk.Orientation.VERTICAL, 0);
        // The home directory
        string temporaryFilesDirectory = Environment.get_tmp_dir ();

        // Create the button with the functionality to create a file
        Button writeFile = new Button.with_label ("Create test file in " + temporaryFilesDirectory);
        // On button click
        writeFile.clicked.connect (() => {
          try {
            // The file
            var polkitTutorialFile = File.new_for_path (temporaryFilesDirectory + "/polkit-tutorial-sample-file.txt");
            // Write the file to Documents
            polkitTutorialFile.create (FileCreateFlags.PRIVATE);
          } catch (Error caughtError) {
            stderr.printf ("GLib error. Details: %s", caughtError.message);
          }
    		});
        Button deleteFile = new Button.with_label ("Delete created file from " + temporaryFilesDirectory);
        // On button click
        deleteFile.clicked.connect (() => {
          try {
            // Get the file in a variable
            var polkitTutorialFile = File.new_for_path (temporaryFilesDirectory + "/polkit-tutorial-sample-file.txt");
            // Delete the file
            polkitTutorialFile.delete ();
          } catch (Error caughtError) {
            stderr.printf ("GLib error. Details: %s", caughtError.message);
          }
    		});

        buttonsBox.pack_start (writeFile, false, false, 10);
		    buttonsBox.pack_start (deleteFile, false, false, 10);
        buttonsBox.margin = 10;

        window.add (buttonsBox);
        window.show_all ();
    }

    public static int main (string[] args) {
        var app = new PolkitTutorialApplication ();
        return app.run (args);
    }
}
