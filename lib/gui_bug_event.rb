# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'gui_bug'
require 'gui'

# Class describing the actions and event in the bug reporting dialog.
class GUIBugEvent < GUIBug

    # The bug report window is initialized.
    def initialize(parent)
        super

        @parent = parent
        evt_close()                     {exit_dlg}
        evt_button(@submit_btn)         {create_report()}
    end

    # Exits the dialog and shows the main window.
    def exit_dlg()
        @parent.show
        self.destroy
    end

    # Creates a bug report and saves it to the bug folder so it can be emailed
    # to a developer.
    def create_report()
        report = <<STR_END
#### STEPS TO REPRODUCE BUG ####

#{@list_steps_text.get_value}


#### DESCRIPTION OF BUG ####

#{@description_text.get_value}

--#{@reproduce_check.get_value}
--#{@past_check.get_value}


#### SESSION LOG ####

#{@parent.log_text.get_value}


--------------------------------------------------------------------------------
#{IO.readlines($attr[:name]).join("\n") if $attr[:name]}
STR_END
        
        fname = "bugs/#{Time.now.to_s.split(" ").join("_")}_#{$attr[:name].split(/[\/\\]/).join("_") if $attr[:name]}_bug"
        File.open(fname, 'w') {|fout| fout.write(report)}
        prompt = MessageDialog.new(self, "Bug report saved to file: #{fname}\nPlease email this file to the developer!",
                "Bug Report Created", OK)
        exit_dlg() if prompt.show_modal == ID_OK
    end
end
